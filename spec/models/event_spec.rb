require 'rails_helper'

RSpec.describe Event, type: :model do
  xit { should have_many(:contacts).class_name('User') }
  xit { should have_many(:events) }
end
