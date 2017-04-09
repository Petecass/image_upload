FactoryGirl.define do
  factory :image do
    title Faker::Name.first_name
    author Faker::Name.first_name
    url Faker::Name.first_name

    trait :with_attachment do
      image Rack::Test::UploadedFile.new(File.open(File.join(File.dirname(__FILE__), 'test.jpg')))
    end
  end
end
