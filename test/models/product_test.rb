require "test_helper"

class ProductTest < ActiveSupport::TestCase

  test "product is valid" do
    assert products(:one).valid?
    assert products(:two).valid?
  end

  test "can not save without name" do
    products(:one).update(name: "")
    assert_not products(:one).valid?
  end

  test "must hold a user" do
    products(:one).update(user: nil)
    assert_not products(:one).valid?
  end

  test "can not save without price" do
    products(:one).update(price: nil)
    assert_not products(:one).valid?
  end

  test "two product code must not be the same" do
    products(:two).product_code = products(:one).product_code
    assert_not products(:two).valid?
  end

  test "product generates unique product code" do
    product_1 = Product.new(name: "bla", price: 100, user: users(:foo))
    product_2 = Product.new(name: "sra", price: 100, user: users(:bar))

    product_1.save
    product_2.save

    assert_not_equal product_1.product_code, product_2.product_code
  end
end
