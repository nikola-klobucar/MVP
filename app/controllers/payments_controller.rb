class PaymentsController < ApplicationController
    include PaymentsHelper

    skip_before_action :verify_authenticity_token

    def new
        @payment = Payment.new
        set_up_credit_card_form
    end

    def create
        @payment = Payment.new(payment_result: payment_params)
        respond_to do |format|
            if @payment.save
                current_cart.order.update(payment: @payment)
                format.html { redirect_to root_path, notice: "Payment was successfully conducted" }
                format.json { status :created }
            else
                format.html { redirect_to new_payment_path, notice: "Payment was not successfully conducted" }
                format.json { render json: @payment.errors, status: :unprocessable_entity }
            end
        end
    end

    def update_if_valid
        @raw_request = request.body.read
        @payment = Cart.find_by_id(JSON.parse(@raw_request)["custom_params"]).order.payment
        respond_to do |format|
            if @payment.update(payment_result: @raw_request)
                format.html { redirect_to root_path, notice: "Payment was successfully conducted" }
                format.json { status :updated }
            else
                format.html { redirect_to new_payment_path, notice: "Payment was not successfully conducted" }
                format.json { render json: @payment.errors, status: :unprocessable_entity }
            end
        end
    end


    private
        def payment_params
            params.require(:payment)
        end
end
