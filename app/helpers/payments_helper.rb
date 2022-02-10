module PaymentsHelper
    # def current_order
    #     if session[:order_number].present?
    #         Order.find_by_order_number(session[:order_number])
    #     else
    #         Order.new
    #     end
    # end
    
    def set_up_credit_card_form
        @order = current_cart.order
        @response = @order.send_transaction
        @client_secret = JSON.parse(@response.body)["client_secret"]
        @order.update(client_secret: @client_secret)
        gon.merchant_key = Rails.application.credentials.config[:web_pay][:merchant_key]
        gon.client_secret = @order.client_secret
        gon.address = @order.address
        gon.country = @order.country
    end
    
end
