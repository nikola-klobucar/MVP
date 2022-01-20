require 'faker'

puts "Creating a user"

@user = User.new(email: "foo@bar.com", password: 123456, password_confirmation: 123456)
@user.save

puts "Creating an admin"

@admin_user = AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

puts "Creating products"

10.times do
    @product = Product.new(
        name: Faker::Device.model_name,
        description: Faker::Lorem.sentences(number: 1),
        specs: Faker::Lorem.sentences(number: 1),
        product_code: Faker::Alphanumeric.alpha(number: 10),
        admin_user: @admin_user,
        price_cents: Faker::Number.within(range: 100..1000)
    )
    @product.save
end

