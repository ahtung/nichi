require 'rails_helper'

RSpec.describe Calendar, type: :model do
  it { should belong_to(:user) }
end
