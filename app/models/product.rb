class Product < ApplicationRecord
    validates :name, presence: true
    validates :product_code, uniqueness: true

    belongs_to :user

    before_create :generate_product_code

    def self.search(params)
        where("LOWER(name) LIKE :term", 
        term: "%#{params}%")
    end

    private
        def generate_product_code
            self.product_code = (0...8).map { (65 + rand(26)).chr }.join
        end
end
