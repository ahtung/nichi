class Event < ActiveRecord::Base
  # Relations
  belongs_to :owner, class_name: 'User'
  has_many :invitations, dependent: :destroy
  has_many :users, through: :invitations

  # Validations
  validates :name, presence: true
  validates :owner, presence: true
  validate :validate_users

  # Instance methods
  def validate_users
    errors.add(:users, 'No guests? :S') unless users.present?
  end

  def invite(guests)
    users << guests
  end
end
