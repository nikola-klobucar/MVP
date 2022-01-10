class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.text :specs
      t.string :product_code

      t.timestamps
    end
  end
end
