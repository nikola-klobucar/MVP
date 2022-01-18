class AddOrderInfoToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :order_info, :string, default: "This is an Order Info"
  end
end
