class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  scope :to, ->(event) { where event: event }
  scope :for, ->(user) { where user: user }

  def event_name
    event.name
  end

  def reject
    destroy
  end
end
