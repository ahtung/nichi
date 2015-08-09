class Event < ActiveRecord::Base
  # Relations
  belongs_to :owner, class_name: 'User'
  has_many :invitations, dependent: :destroy
  has_many :users, through: :invitations

  # Validations
  validates :name, presence: true
  validates :owner, presence: true

  # Instance methods
  def invite(guests)
    users << guests
  end
end
