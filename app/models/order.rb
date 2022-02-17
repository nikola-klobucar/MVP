class Order < ApplicationRecord
    has_one :cart
    belongs_to :user
    belongs_to :payment, optional: true

    validates :order_number, presence: true

    before_save :set_subtotal
    before_validation :generate_order_number

    enum transaction_type: {
        authorize: "authorize",
        purchase: "purchase"
    }

    def subtotal
        cart.order_items.collect { |order_item| order_item.valid? ? (order_item.unit_price * order_item.quantity) : 0}.sum
    end

    def send_transaction
        time = Time.now.to_i.to_s

        req = {
            "amount": (subtotal * 100).to_i,
            "order_number": order_number,
            "currency": CURRENCY,
            "transaction_type": transaction_type,
            "order_info": order_info,
            "scenario": "charge",
            "supported_payment_method": ["card"],
            "custom_params": cart[:id].to_s
        }

        body_as_string = req.to_json
        merchant_key = Rails.application.credentials.config[:web_pay][:merchant_key]
        auth_token = Rails.application.credentials.config[:web_pay][:authenticity_token]
        digest = Digest::SHA2.new(512).hexdigest(merchant_key + time + auth_token + body_as_string)

        url = 'https://ipgtest.monri.com'

        headers = {
            "Content-Type" => "application/json",
            "Content-Length" => body_as_string.length.to_s,
            "Authorization" => "WP3-v2 " + auth_token + " " + time + " " + digest 
        }

        conn = Faraday.new(
            url: url
        )

        return conn.post('/v2/payment/new', body_as_string, headers)
    end

    private
        def set_subtotal
            self[:subtotal] = subtotal
        end

        def generate_order_number
            self.order_number = SecureRandom.hex(10) + Time.now.to_i.to_s
        end
end
