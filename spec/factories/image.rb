FactoryGirl.define do
  factory :image do
    title Faker::Name.first_name
    author Faker::Name.first_name
    url Faker::Name.first_name
  end
end
