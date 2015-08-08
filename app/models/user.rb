class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  # Relations
  has_many :events, dependent: :destroy, foreign_key: 'owner_id'
  has_many :contacts, class_name: 'User'

  def self.find_for_google_oauth2(access_token, _ = nil)
    data = access_token.info
    user = User.find_by(email: data['email'])
    unless user
      user = User.create(
        email: data['email'],
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end
end
