class RemoveMonetizeFromProducts < ActiveRecord::Migration[6.1]
  def change
    remove_monetize :products, :price_cents
  end
end
