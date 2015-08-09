FactoryGirl.define do
  factory :event do
    name { Faker::Name.title }
    owner { create(:user) }
    users { create_list(:user, 2) }
  end
end
