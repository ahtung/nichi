FactoryGirl.define do
  factory :event do
    name { Faker::Name.title }
  end
end
