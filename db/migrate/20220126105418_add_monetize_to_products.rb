class AddMonetizeToProducts < ActiveRecord::Migration[6.1]
  def change
    add_monetize :products, :price
  end
end
