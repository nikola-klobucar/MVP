class ChangePaymentColumns < ActiveRecord::Migration[6.1]
  def change
    remove_column :payments, :card_number
    remove_column :payments, :exp_date
    remove_column :payments, :cvv
    add_column :payments, :payment_result, :string
  end
end
