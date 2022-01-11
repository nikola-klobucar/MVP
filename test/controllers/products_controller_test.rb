require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @user = users(:baz)
  end


  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should get new" do
    get new_product_path
    assert_response :success
  end

  test "should not create new product without authorization" do
    assert_no_difference('Product.count') do
      post products_path, params: {product: 
                                    {name: @product.name, 
                                    description: @product.description,
                                    specs: @product.specs,
                                    product_code: "somethingelse"}
                                  }
    end
    assert_redirected_to new_user_session_path
  end

  test "should show the product" do
    get product_path(@product)
    assert_response :success
  end

  test "shozld get edit" do
    get edit_product_path(@product)
    assert_response :success
  end
end
