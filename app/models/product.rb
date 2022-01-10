class Product < ApplicationRecord
    validates :name, presence: true
    validates :product_code, uniqueness: true

    belongs_to :user

    before_create :generate_product_code

    private
        def generate_product_code
            self.product_code = (0...8).map { (65 + rand(26)).chr }.join
        end
end
