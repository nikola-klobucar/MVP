class AddRefundToPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :refund, :boolean, default: false
  end
end
