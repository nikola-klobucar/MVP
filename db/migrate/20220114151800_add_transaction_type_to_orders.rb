class AddTransactionTypeToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :transaction_type, :string, default: "authorize"
  end
end
