ActiveAdmin.register User do

  filter :products

  index do
    selectable_column
    column :id
    column :email
    column :products
    actions
  end
  
end
