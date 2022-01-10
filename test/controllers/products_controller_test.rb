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

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: {product: 
                                    {name: @product.name, 
                                    description: @product.description,
                                    specs: @product.specs,
                                    product_code: "somethingelse",
                                    user: @user }
                                  }
    end
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
