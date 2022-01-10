class Product < ApplicationRecord
    validates :name, presence: true
    validates :product_code, presence: true, uniqueness: true
end
