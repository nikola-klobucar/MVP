class RemoveCurrencyFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :currency
    add_column :products, :currency, :string, default: :eur
  end
end
