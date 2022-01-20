ActiveAdmin.register User do

  index do
    selectable_column
    column :id
    column :email
    column :orders
    actions
  end
  
end
