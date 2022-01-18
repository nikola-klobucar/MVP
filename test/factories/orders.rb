FactoryBot.define do
  factory :order do
    subtotal { 1.5 }
    total { 0 }
    user
  end
end
