class AddClientSecretToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :client_secret, :string
  end
end
