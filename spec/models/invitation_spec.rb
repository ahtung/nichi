require 'rails_helper'

RSpec.describe Invitation, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:event) }

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
end
