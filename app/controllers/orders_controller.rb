class OrdersController < ApplicationController

    def index
        @order = current_order
        binding.pry
    end

    def update
        @order = current_order.update(order_params)
        @order = current_order
        redirect_to new_payment_path
    end

    private

        def order_params
            params.require(:order).permit(:user, :city, 
                :address, :phone, :zip_code, :country,
                :comment, :transaction_type,
                :order_info, :order_number, :currency, :payment_id)
        end
end
