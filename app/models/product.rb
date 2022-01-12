class Product < ApplicationRecord
    before_create :generate_product_code

    validates :name, :price_cents, presence: true
    validates :product_code, uniqueness: true

    belongs_to :user
    has_many :order_items

    monetize :price_cents
    
    def self.search(params)
        where("LOWER(name) LIKE :term", 
        term: "%#{params}%")
    end

    private
        def generate_product_code
            self.product_code = (0...8).map { (65 + rand(26)).chr }.join
        end
end
