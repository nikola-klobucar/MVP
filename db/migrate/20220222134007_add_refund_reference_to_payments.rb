class AddRefundReferenceToPayments < ActiveRecord::Migration[6.1]
  def change
    add_reference :refund_references, :payment, null: false, foreign_key: true
  end
end
