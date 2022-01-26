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
    assert_response :success
  end

  test "can update order_item quantity" do
    post order_items_url, params: { order_item: {product_id: products(:product_one).id, quantity: 1}}
    assert_response :success
    @order_item = OrderItem.last
    @order_item.update(quantity: 2)
    assert_equal @order_item.total_price, 20

    # @order_item = OrderItem.last
    # assert_difference("OrderItem.last.total_price", 10) do
    #   patch edit_order_item_url(@order_item), params: {order_item: { quantity: 2}}
    # end
  end

  # test "can delete order item" do
  #   @order_item = order_items(:order_item_one)
  #   order.order_items.update(@order_item)
  #   assert_difference("OrderItem.count", -1) do
  #     delete order_item_path(@order_item)
  #   end
  # end
end
