require 'rails_helper'

RSpec.describe Event, type: :model do
  # Relations
  it { should belong_to(:owner).class_name('User') }
  it { should have_many(:invitations).dependent(:destroy) }
  it { should have_many(:users).class_name('User').through(:invitations) }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:owner) }
  # guest count should be > 0

  # DB Indexes
  it { should have_db_index(:owner_id) }

  describe '#' do
    describe 'invite' do
      let!(:event){ create(:event) }
      let(:guests) { create_list(:user, 3) }

      it 'should create invitations' do
        expect{ event.invite(guests) }.to change{ Invitation.count }.by(guests.count)
      end
    end
  end
end
