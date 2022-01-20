class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def new
        @payment = Payment.new
        @order = current_order
        @order.currency = current_order.products.first.currency
        @response = @order.send_transaction
        @client_secret = JSON.parse(@response.body)["client_secret"]
        @order.update(client_secret: @client_secret)
        gon.client_secret = @client_secret
        gon.address = @order.address
        gon.country = @order.country
        session[:order_id] = nil
    end

    def create
        # @payment = Payment.new(payment_params)
        # @payment.save
        # @order = current_order
        # @order.payment = @payment
    end


    # private

    #     def payment_params
    #         params.require(:payment).permit(:card_number, :cvv, :exp_date)
    #     end
end
