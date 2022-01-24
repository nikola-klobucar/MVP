ActiveAdmin.register Payment do
  
    index do
      selectable_column
      column :payment_result
      actions
    end
    
  end