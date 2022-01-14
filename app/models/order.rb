class Order < ApplicationRecord
    has_many :order_items, dependent: :destroy
    has_many :products, through: :order_items
    belongs_to :user

    before_save :set_subtotal

    enum transaction_type: {
        authorize: "authorize",
        purchase: "purchase"
    }

    def subtotal
        @total = 0
        # order_items.collect { |order_item| order_item.valid? ? (order_item.unit_price * order_item.quantity) : 0}.sum
        order_items.each do |order_item|
            price_of_one_item = order_item.unit_price * order_item.quantity

            if price_of_one_item.kind_of? Float
                @total += price_of_one_item
            else
                price_of_one_item = price_of_one_item.cents/100
                @total += price_of_one_item
            end

        end
        return @total
    end

    private
        def set_subtotal
            self[:subtotal] = subtotal
        end
end
