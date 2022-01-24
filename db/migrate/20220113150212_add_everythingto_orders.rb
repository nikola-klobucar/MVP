class AddEverythingtoOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :currency, :string, default: :eur
    add_column :orders, :address, :string
    add_column :orders, :city, :string
    add_column :orders, :zip_code, :integer
    add_column :orders, :card_number, :integer
    add_column :orders, :exp_date, :date
    add_column :orders, :cvv, :integer
    add_column :orders, :phone, :string
    add_column :orders, :comment, :text
    add_reference :orders, :user
  end
end
