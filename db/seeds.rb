require 'faker'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
10.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: Faker::Address.full_address
  )
end

50.times do
  Product.create!(
    name: Faker::Science.element,
    price: Faker::Commerce.price(range: 0..1000.0),
    description: Faker::Lorem.sentence,
    user_id: Faker::Number.between(from: 1, to: 10)
  )
end

