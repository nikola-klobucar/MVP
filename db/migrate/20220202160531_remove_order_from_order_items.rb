class RemoveOrderFromOrderItems < ActiveRecord::Migration[6.1]
  def change
    remove_reference :order_items, :order, null: false, foreign_key: true
  end
end
