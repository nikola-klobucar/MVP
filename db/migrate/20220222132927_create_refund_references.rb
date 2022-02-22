class CreateRefundReferences < ActiveRecord::Migration[6.1]
  def change
    create_table :refund_references do |t|
      t.string :response, null: false
      t.timestamps
    end
  end
end
