class OrdersController < ApplicationController

    def index
        @order = current_order
    end

    def update
        @order = current_order.update(order_params)
        # @payment = Payment.new(order_params)
        # @response = @payment.send_trasaction
        redirect_to new_payment_path
    end

    private

        def order_params
            params.require(:order).permit(:user, :city, 
                :address, :phone, :zip_code, 
                :comment, :transaction_type,
                :order_info, :order_number, :currency, :payment_id)
        end
end
