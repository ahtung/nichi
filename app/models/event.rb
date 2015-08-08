class Event < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :invitations, dependent: :destroy
  has_many :users, through: :invitations

  # Instance methods
  def invite(guests)
    users << guests
  end
end
