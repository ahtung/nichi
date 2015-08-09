FactoryGirl.define do
  factory :event do
    name { Faker::Name.title }
    owner { create(:user) }
  end
end
