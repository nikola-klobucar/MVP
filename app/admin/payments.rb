ActiveAdmin.register Payment do
  
    index do
      selectable_column
      column :payment_result
      actions
    end

    form do |f|
      f.inputs :refund
      f.actions
    end
  end