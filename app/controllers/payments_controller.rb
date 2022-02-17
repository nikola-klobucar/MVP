class PaymentsController < ApplicationController
    include PaymentsHelper

    skip_before_action :verify_authenticity_token

    def new
        @payment = Payment.new
        set_up_credit_card_form
    end

    def create
        @parsed_request = request.body.read
        @payment = Payment.new(payment_result: @parsed_request)
        respond_to do |format|
            if @payment.save
                @order = Cart.find_by_id(JSON.parse(@parsed_request)["custom_params"]).order
                @order.update(payment: @payment)
                format.html { redirect_to root_path, notice: "Order was successfully ordered" }
                format.json { status :created }
            else
                format.html { redirect_to new_payment_path, notice: "Order was not successfully ordered" }
                format.json { render json: @payment.errors, status: :unprocessable_entity }
            end
        end
    end


    private
        def payment_params
            params.require(:payment).permit(:payment_result, :refund)
        end
end
