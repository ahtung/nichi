require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:friendships).dependent(:destroy) }
  it { should have_many(:contacts).through(:friendships).class_name('User') }
  it { should have_many(:events).dependent(:destroy) }
  it { should have_many(:invitations).dependent(:destroy) }
  it { should have_many(:invited_events).through(:invitations).class_name('Event') }
end
