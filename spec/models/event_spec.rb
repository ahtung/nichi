require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to(:owner).class_name('User') }
  it { should have_many(:invitations) }
  it { should have_many(:guests).class_name('User').through(:invitations) }

  describe '#' do
    describe 'invite' do
      let(:event){ create(:event) }
      let(:guests) { create_list(:user, 3) }

      xit 'should create invitations' do
        expect{ event.invite(guests) }.to change{ Invitation.count }.by(guests.count)
      end
    end
  end
end
