require 'faker'

puts "Creating a user"

@user = User.new(email: "foo@bar.com", password: 123456, password_confirmation: 123456)
@user.admin = true
@user.save

puts "Creating products"

10.times do
    Product.create(
        name: Faker::Device.model_name,
        description: Faker::Lorem.sentences(number: 1),
        specs: Faker::Lorem.sentences(number: 1),
        product_code: Faker::Alphanumeric.alpha(number: 10),
        user_id: @user.id
    )
end