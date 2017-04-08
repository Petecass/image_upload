FactoryGirl.define do
  factory :tag do
    name Faker::Name.first_name
    image
  end
end