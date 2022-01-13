class RemoveColumnsFromProducts < ActiveRecord::Migration[6.1]
  def change
    remove_reference :products, :user, index: true, foreign_key: true
  end
end
