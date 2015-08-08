class Event < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :invitations, dependent: :destroy
  has_many :guests, class_name: 'User', through: :invitations, source: 'User'

  # Instance methods
  def invite(guests)
    self.guests << guests
  end
end
