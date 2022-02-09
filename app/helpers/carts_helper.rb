module CartsHelper
  def cart_sum(order_items)
    sum = 0
    order_items.each do |total| 
      sum += total.total_price
    end  
    
    sum
  end
  
  def errors?
    !@order_item.nil? && @order_item.errors.any?
  end
end
