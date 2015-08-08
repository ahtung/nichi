require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to(:owner).class_name('User') }
  it { should have_many(:invitations) }
  it { should have_many(:guests).class_name('User').through(:invitations) }
end
