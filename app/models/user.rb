class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  # Relations
  has_many :invitations, dependent: :destroy
  has_many :invited_events, through: :invitations, class_name: 'Event'
  has_many :events, dependent: :destroy, foreign_key: 'owner_id'
  has_many :friendships, dependent: :destroy
  has_many :calendars, dependent: :destroy
  has_many :contacts, class_name: 'User', through: :friendships

  after_commit :schedule_import_contacts, on: [:update, :create]
  after_validation :create_calendar

  # A method nedeed by omniauth-google-oauth2 gem
  # User is being created if it does not exist
  def self.find_for_google_oauth2(access_token, _ = nil)
    user = User.where(email: access_token.info.email).first_or_create
    user.update(
      refresh_token: access_token.credentials.token,
      name: access_token.info.name
    )
    user
  end

  def password_required?
    false
  end

  # import user's contacts from google
  def import_contacts
    Rails.logger.info 'import_contacts'
    return unless access_token
    google_contacts_user = GoogleContactsApi::User.new(access_token)
    Rails.logger.info google_contacts_user
    conact_details = get_contact_details(google_contacts_user)
    conact_details.each do |conact_detail|
      user = User.where(email: conact_detail[:email]).first_or_create
      user.update(conact_detail)
      contacts << user
    end
    update_attribute(:last_contact_sync_at, DateTime.now)
  end

  def get_contact_details(google_contacts_user)
    contact_info = google_contacts_user.contacts.map do |contact|
      { email: contact.primary_email, name: contact.full_name }
    end
    contact_info.reject { |contact| contact[:email].nil? }
  end

  # Gets the access_token using users's refresh token
  def access_token
    return unless refresh_token
    client = OAuth2::Client.new(
      ENV['GOOGLE_CLIENT_ID'],
      ENV['GOOGLE_CLIENT_SECRET'],
      site: 'https://accounts.google.com',
      authorize_url: '/o/oauth2/auth',
      token_url: '/o/oauth2/token'
    )
    OAuth2::AccessToken.from_hash(client, refresh_token: refresh_token).refresh!
  end

  def contacts_for_select
    contacts.collect { |contact| [contact.name, contact.id] }
  end

  private

  # Scehdule an import of the user's contact list after it is committed
  def schedule_import_contacts
    FriendSyncWorker.perform_in(10.seconds, id) if last_contact_sync_at.nil?
  end

  def create_calendar
    return unless calendars.empty?
    return unless refresh_token
    client = Google::APIClient.new
    client.authorization.access_token = refresh_token
    service = client.discovered_api('calendar', 'v3')
    calendar = client.execute(api_method: service.calendars.insert, body: JSON.dump({ 'summary' => 'nichi Calendar' }), headers: { 'Content-Type' => 'application/json'})
    if calendar.status == 200
      google_calendar_id = ActiveSupport::JSON.decode(calendar.response.body)['id']
      calendars.create(google_id: google_calendar_id)
    end
  end
end
