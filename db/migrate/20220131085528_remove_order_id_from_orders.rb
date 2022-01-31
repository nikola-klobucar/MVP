class RemoveOrderIdFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_reference :order_items, :order
  end
end
