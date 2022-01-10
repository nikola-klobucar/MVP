require 'faker'

puts "Creating products"


10.times do
    Product.create(
        name: Faker::Device.model_name,
        description: Faker::Lorem.sentences(number: 1),
        specs: Faker::Lorem.sentences(number: 1),
        product_code: Faker::Alphanumeric.alpha(number: 10)
    )
end