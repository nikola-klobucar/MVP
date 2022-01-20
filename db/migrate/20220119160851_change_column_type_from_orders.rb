class ChangeColumnTypeFromOrders < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :subtotal, :integer
    change_column :orders, :total, :integer
  end
end
