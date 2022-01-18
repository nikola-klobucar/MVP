class RemoveCardFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :card_number
    remove_column :orders, :exp_date
    remove_column :orders, :cvv
  end
end
