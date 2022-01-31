class Cart < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :user
  
  has_many :order_items, dependent: :destroy
end
