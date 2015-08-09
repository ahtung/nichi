require 'rails_helper'

RSpec.describe Invitation, type: :model do
  # Relations
  it { should belong_to(:user) }
  it { should belong_to(:event) }

  # Validations
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:event) }

  # Class methods
  describe '.' do
    let(:users) { create_list(:user, 1) }
    let(:event) { create(:event, users: users) }

    describe 'to' do
      xit 'scope event' do
        expect(users.first.invitations.to(event)).to match_array(users.invitations)
      end
    end

    describe 'for' do
      it 'scope user' do
        expect(event.invitations.for(users.first)).to match_array(event.invitations)
      end
    end
  end

  # Instnce methods
  describe '#' do
    let(:invitation) { create(:invitation) }

    describe 'event_name' do
      it 'should return event.name' do
        expect(invitation.event_name).to eq(invitation.event.name)
      end
    end

    describe 'reject' do
      it 'should call destroy' do
        expect(invitation.reject).to receive(:destroy)
        invitation.reject
      end
    end
  end
end
