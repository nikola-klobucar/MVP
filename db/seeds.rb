require 'faker'

puts "Creating a users"

@user = User.new(email: "foo@bar.com", password: 123456, password_confirmation: 123456)
@user.save
@user_2 = User.new(email: "nklobucbbb@gmail.com", password: 123456, password_confirmation: 123456)
@user_2.save

puts "Creating an admin"

@admin_user = AdminUser.new(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
@admin_user.save!
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
    @product.save!
end

