require 'faker'

puts "Creating a user"

@user = User.new(email: "foo@bar.com", password: 123456, password_confirmation: 123456)
@user.save

puts "Creating products"

10.times do
    @product = Product.new(
        name: Faker::Device.model_name,
        description: Faker::Lorem.sentences(number: 1),
        specs: Faker::Lorem.sentences(number: 1),
        product_code: Faker::Alphanumeric.alpha(number: 10),
        user_id: @user.id,
        price_cents: Faker::Number.decimal(l_digits: 3)
    )
    @product.save
end

puts "Creating an admin"

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?