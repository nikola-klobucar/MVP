require "test_helper"

class OrderItemsControllerTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def order
    orders(:order_one)
  end

  def setup
    sign_in users(:foo)
  end

  test "equality of order item and product" do
    @order_item = order_items(:order_item_one).product
    @product = products(:product_one)
    assert_equal(@order_item, @product)
  end

  test "can create an order item" do
    assert_difference("OrderItem.count") do
      post order_items_url, params: { order_item: {product_id: products(:product_one).id, quantity: 1}}
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "h1", "All Products"
  end

  test "can update order_item quantity" do
    updated_quantity = 5
    # patch order_item_url, params: {order_item: {id: order_item.id, product_id: products(:product_one).id, quantity: updated_quantity}}
    patch order_item_url(OrderItem.last), params: {order_item: {quantity: updated_quantity}}

    assert_equal updated_quantity, OrderItem.last.quantity
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "can delete order item" do
    assert_difference("OrderItem.count", -1) do
      delete order_item_url(OrderItem.last)
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
end
