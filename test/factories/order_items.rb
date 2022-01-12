FactoryBot.define do
  factory :order_item do
    product_id { 1 }
    order_id { 1 }
    unit_price { 1.5 }
    quantity { 1 }
    total_price { 1.5 }
  end
end
