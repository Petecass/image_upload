require 'faker'

4.times do
  Image.create(
    title: Faker::Name.first_name,
    author: Faker::Name.first_name,
    url: Faker::Name.first_name,
    image: File.open(File.join(File.dirname(__FILE__), 'test.jpg'))
  )
end
