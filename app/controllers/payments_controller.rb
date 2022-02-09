class PaymentsController < ApplicationController
    include PaymentsHelper

    skip_before_action :verify_authenticity_token

    def new
        @payment = Payment.new
        set_up_credit_card_form
    end

    def create
        @payment = Payment.new(:payment_result => params[:payment_result])
        respond_to do |format|
            if @payment.save!
                @order = current_cart.order
                @order.update(payment: @payment)
                Rails.cache.delete(cache_key)
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
            params.require(:payment).permit(:payment_result)
        end
end
