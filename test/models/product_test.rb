require "test_helper"

class ProductTest < ActiveSupport::TestCase

  setup do
    @product = products(:one)
  end

  test "can not save without name" do

    @user = User.new(email: "foo@baz.com", password: 123456, password_confirmation: 123456)
    @user.save

    product = Product.new(name: "", 
                          user: @user, 
                          product_code: "lsjdsadsfk")
    assert_not product.save
  end

  test "the unique product code" do
    product_copy = @product.dup
    
    assert @product
    assert_not product_copy.save

    product_copy.errors.messages[:product_code].include?('has already been taken')
  end
end
