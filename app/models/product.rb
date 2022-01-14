class Product < ApplicationRecord
    before_create :generate_product_code

    validates :name, :price, presence: true
    validates :product_code, uniqueness: true
    validates :currency, presence: true

    monetize :price, as: :price_cents

    has_one :order_item
    belongs_to :admin_user
    
    def self.search(params)
        where("LOWER(name) LIKE :term", 
        term: "%#{params}%")
    end

    private
        def generate_product_code
            self.product_code = (0...8).map { (65 + rand(26)).chr }.join
        end
end
