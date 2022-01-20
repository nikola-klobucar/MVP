ActiveAdmin.register Order do
  
    index do
      selectable_column
      column :order_id
      column :order_info
      column :order_items
      column :currency
      column :payment
      column :country
      actions
    end
    
  end