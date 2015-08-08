require 'rails_helper'

RSpec.describe User, type: :model do
  xit { should have_many(:contacts).class_name('User') }
  it { should have_many(:events).dependent(:destroy) }
  it { should have_many(:invitations).dependent(:destroy) }
  it { should have_many(:invited_events).through(:invitations) }
end
