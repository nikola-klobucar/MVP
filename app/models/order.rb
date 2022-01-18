class Order < ApplicationRecord
    has_many :order_items, dependent: :destroy
    has_many :products, through: :order_items
    belongs_to :user
    belongs_to :payment, optional: true

    before_save :set_subtotal
    before_create :generate_order_number

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

    def send_transaction
        time = Time.now.to_i.to_s

        req = {
            "amount": (subtotal * 100).to_i,
            "order_number": order_number,
            "currency": currency.upcase,
            "transaction_type": transaction_type,
            "order_info": order_info,
            "scenario": "charge",
            "supported_payment_method": ["blasra"]
        }
        body_as_string = req.to_json
        merchent_key = Rails.application.credentials.config[:web_pay][:merchent_key]
        auth_token = Rails.application.credentials.config[:web_pay][:authenticity_token]
        digest = Digest::SHA2.new(512).hexdigest(merchent_key + time + auth_token + body_as_string)

        url = 'https://ipgtest.monri.com'

        glava = {
            "Content-Type" => "application/json",
            "Content-Length" => body_as_string.length.to_s,
            "Authorization" => "WP3-v2 " + auth_token + " " + time + " " + digest 
        }

        conn = Faraday.new(
            url: url
        )

        return conn.post('/v2/payment/new', body_as_string, glava)
    end

    private
        def set_subtotal
            self[:subtotal] = subtotal
        end

        def generate_order_number
            self.order_number = SecureRandom.hex(10) + Time.now.to_i.to_s
        end
end
