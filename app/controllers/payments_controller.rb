class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def new
        @payment = Payment.new
        @order = current_order
        @response = @order.send_transaction
        @client_secret = JSON.parse(@response.body)["client_secret"]
        @order.update(client_secret: @client_secret)
        gon.merchent_key = Rails.application.credentials.config[:web_pay][:merchent_key]
        gon.client_secret = @order.client_secret
        gon.address = @order.address
        gon.country = @order.country
        binding.pry
    end

    def create
        @order = current_order
        @payment = Payment.new(payment_params)
        binding.pry
        respond_to do |format|
            if @payment.save
                binding.pry
                @order.update(payment: @payment)
                session[:order_id] = nil
                format.html { redirect_to order_path(@order), notice: "Order was successfully ordered" }
                format.json { status :created }
            else
                format.html { redirect_to new_payment_path, notice: "Order was not successfully ordered" }
                format.json { render json: @payment.errors, status: :unprocessable_entity }
            end
        end
    end


    private

        def payment_params
            params.require(:payment).permit(:id, :created_at, :payment_result)
        end
end
