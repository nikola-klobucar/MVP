require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "can not save without name and product code" do
    product = Product.new
    assert_not product.save
  end
end
