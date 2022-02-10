ActiveAdmin.register Product do
  permit_params :name, :description, :specs, :price_cents, :sold, :product_code, :admin_user_id

  includes :admin_user

  filter :name
  filter :admin_user
  filter :sold

  index do
    selectable_column
    column :id
    column :name
    column :description
    column :specs
    column :sold?
    column :product_code
    column :admin_user
    column :price_cents
    actions
  end

  form do |f|
    f.inputs :name, :description, :specs, :price_cents, :sold, :admin_user
    f.actions
  end
  
end
