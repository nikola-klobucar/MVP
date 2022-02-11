require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest

  def order
    orders(:order_one)
  end

  def setup
    sign_in users(:foo)
  end

  test "can create Order" do
    post order_items_url, params: { order_item: {product_id: products(:product_one).id, quantity: 1}}
    Cart.first.order_items << OrderItem.all
    assert_difference("Order.count") do
      post orders_url, params: {
        order: {
          currency: CURRENCY, address: "Address 2",
          city: "City 2", zip_code: 10000, phone: "003851111111", 
          transaction_type: "authorize"
        }
      }
    end
    assert_equal Cart.first.order.order_number, Order.last.order_number
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "can show the order" do
    get user_path(users(:foo).id)
    assert_response :success
    assert_equal order, users(:foo).orders.first
  end

end
