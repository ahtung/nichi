require 'rails_helper'

RSpec.describe Friendship, type: :model do
  # Relations
  it { should belong_to(:user) }
  it { should belong_to(:contact).class_name('User') }

  # DB Indexes
  it { should have_db_index(:user_id) }
  it { should have_db_index(:contact_id) }
end
