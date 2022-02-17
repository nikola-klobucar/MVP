class Payment < ApplicationRecord
    has_one :order, dependent: :destroy

    def refund_functionality

        @hashed_payment_result = JSON.parse(payment_result)

        time = Time.now.to_i.to_s

        req = {
            "id": @hashed_payment_result["id"].to_s,
            "order_number": @hashed_payment_result["order_number"],
            "transaction_type": "refund",
            "authenticity-token": Rails.application.credentials.config[:web_pay][:authenticity_token],
            "amount": @hashed_payment_result["amount"].to_s,
            "currency": @hashed_payment_result["currency"]
        }
        
        merchent_key = Rails.application.credentials.config[:web_pay][:merchant_key]
        digest = Digest::SHA1.new.hexdigest(merchent_key + req[:order_number] + req[:amount] + req[:currency])
        
        req["digest"] = digest
        body_as_xml = req.to_xml(:root => 'transaction')

        # ---------------------
        # Doing requests after this line
        # ---------------------
        
        
        url = 'https://ipgtest.monri.com'
        
        headers = {
            "Content-Type" => "application/xml",
            "Content-Length" => body_as_xml.length.to_s,
            "Authorization" => "WP3-v2 " + req[:"authenticity-token"] + " " + time + " " + digest 
        }
        
        conn = Faraday.new(
            url: url
        )
        response = conn.post("/transactions/#{req[:id]}/refund.xml", body_as_xml, headers)
    end
end
