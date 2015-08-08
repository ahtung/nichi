class Event < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :invitations, dependent: :destroy
  has_many :guests, class_name: 'User', through: :invitations
end
