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

  test "can create a project" do
    assert_difference("Product.count") do
      post admin_products_url, params: { product: { name: "Produkt", price: 300}}
    end
  end
end
