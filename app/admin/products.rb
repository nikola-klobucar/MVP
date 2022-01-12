ActiveAdmin.register Product do
  permit_params :name, :description, :specs, :sold, :user_id, :price_cents

  includes :user

  filter :name
  filter :user
  filter :sold

  index do
    selectable_column
    column :id
    column :name
    column :description
    column :specs
    column :sold?
    column :product_code
    column :user
    column :price_cents
    actions
  end

  form do |f|
    f.inputs :name, :description, :specs, :price_cents, :sold
    actions
  end
  
end
