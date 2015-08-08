require 'rails_helper'

RSpec.describe Invitation, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:event) }

  describe '.' do
    let(:users) { create_list(:user, 1) }
    let(:event) { create(:event, guests: users) }

    describe 'to' do
      xit 'scope event' do
        expect(Invitation.to(event)).to eq(users)
      end
    end

    describe 'for' do
      xit 'scope user' do
        expect(Invitation.for(users.first)).to eq(event)
      end
    end
  end
end
