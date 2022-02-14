require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest

  def setup
    sign_in admin_users(:admin)
  end

  test "should get index" do
    sign_out :admin
    get root_url
    assert_response :success
  end

  test "redirected if user is not logged in" do
    sign_out :admin
    get new_admin_product_url
    assert_response :success
  end

  test "should get to admin dashboard page" do
    get admin_users_url
    assert_response :success
  end

  test "should get to the new projects page" do
    get admin_products_url
    assert_response :success
  end

  test "can create a product" do
    assert_difference("Product.count") do
      post admin_products_url, params: { product: { name: "Produkt", price_cents: 30000, admin_user_id: admin_users(:admin).id}, price_currency: CURRENCY}
    end
    assert_equal "Produkt", Product.last.name
    assert_equal 30000, Product.last.price_cents
    assert_not_equal Product.last.product_code, Product.first.product_code
    assert_equal CURRENCY, Product.last.price_currency
  end
end
