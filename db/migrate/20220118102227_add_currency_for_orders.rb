class AddCurrencyForOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :currency, :string
  end
end
