module OrderItemsHelper

  def order_item_iteration(order_item)
    if current_cart.order_items.empty?
      false
    else
      current_cart.order_items.each do |oi|
        @same_product = oi[:product_id].equal?(order_item[:product_id])
        
        unless @same_product
          next
        end
        
        return true if @same_product == true
      end
    end

    if @same_product
      true
    else
      false
    end
  end

  def save_new_or_existing_order_item(order_items_params)
    product_id = order_items_params[:product_id].to_i
    @order_item = OrderItem.new(order_items_params)

    if order_item_iteration(@order_item)  # If the item already exists
      @existing_item = current_cart.order_items.find_by_product_id(product_id)
      @new_quantity = order_items_params[:quantity].to_i
      @existing_item.quantity += @new_quantity
      @existing_item.save
    else
      @order_item.save  # Complitely new item
      current_cart.order_items << @order_item
    end
  end

  def update_existing_order_item(order_items_params)
    @order_item = OrderItem.find(params[:id])

    unless @order_item.cart == current_cart  # Logic for test passing
        @order_item.cart = current_cart
        current_cart.order_items << @order_item
    end
    product_id = order_items_params[:product_id] # Quantity incrementing or decrementing in the current cart
    current_cart.order_items.include?(OrderItem.find_by_product_id(product_id))
    @order_item.update(order_items_params)
  end
end
