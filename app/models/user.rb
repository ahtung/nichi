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
  # has_many :contacts, class_name: 'User'

  after_commit :schedule_import_contacts

  # A method nedeed by omniauth-google-oauth2 gem
  # User is being created if it does not exist
  def self.find_for_google_oauth2(access_token, _ = nil)
    data = access_token.info
    User.where(email: data['email']).first_or_create(
      name: data['name'],
      refresh_token: (access_token.credentials) ? access_token.credentials.refresh_token : nil
    )
  end

  # import user's contacts from google
  def import_contacts
    return unless access_token
    google_contacts_user = GoogleContactsApi::User.new(access_token)
    conact_details = get_contact_details(google_contacts_user)
    ActiveRecord::Base.transaction do
      begin
        conact_details.each do |conact_detail|
          contacts << User.where(email: conact_detail[:email]).first_or_create.update(conact_detail)
        end
        update_attribute(:last_contact_sync_at, DateTime.now)
      rescue
        next
      end
    end
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

  private

  # Scehdule an import of the user's contact list after it is committed
  def schedule_import_contacts
    FriendSyncWorker.perform_in(id, 10.seconds) if last_contact_sync_at.nil?
  end
end
