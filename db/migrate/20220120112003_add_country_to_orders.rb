class AddCountryToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :country, :string
  end
end
