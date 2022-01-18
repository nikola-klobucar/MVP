class PaymentsController < ApplicationController

    def new
        @payment = Payment.new
    end

    def create
        @payment = Payment.new(payment_params)
        @payment.save
        @order = current_order
        @order.payment = @payment
        @response = @order.send_transaction
        binding.pry
        @client_secret = JSON.parse(@response.body)["client_secret"]
        session[:order_id] = nil
    end


    private

        def payment_params
            params.require(:payment).permit(:card_number, :cvv, :exp_date)
        end
end
