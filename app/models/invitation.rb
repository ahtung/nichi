class Invitation < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :event

  # Validations
  validates :user, presence: true
  validates :event, presence: true

  # Scopes
  scope :to, ->(event) { where event: event }
  scope :for, ->(user) { where user: user }

  # Instance methods
  def event_name
    event.name
  end

  def reject
    destroy
  end
end
