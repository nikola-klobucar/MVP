require "test_helper"

class ProductTest < ActiveSupport::TestCase

  test "product is valid" do
    assert products(:product_one).valid?
    assert products(:product_two).valid?
  end

  test "can not save without name" do
    products(:product_one).update(name: "")
    assert_not products(:product_one).valid?
  end

  test "must hold a admin user" do
    products(:product_one).update(admin_user: nil)
    assert_not products(:product_one).valid?
  end

  test "can not save without price" do
    products(:product_one).update(price_cents: nil)
    assert_not products(:product_one).valid?
  end

  test "two product code must not be the same" do
    products(:product_two).product_code = products(:product_one).product_code
    assert_not products(:product_two).valid?
  end

  test "product generates unique product code" do
    product_1 = Product.new(name: "bla", price_cents: 100, admin_user: admin_users(:admin))
    product_2 = Product.new(name: "sra", price_cents: 100, admin_user: admin_users(:admin))

    product_1.save
    product_2.save

    assert_not_equal product_1.product_code, product_2.product_code
  end
end
