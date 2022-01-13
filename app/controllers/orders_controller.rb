class OrdersController < ApplicationController

    def index
        @order = current_order
    end

    def update
        @order = current_order.update(order_params)
        session[:order_id] = nil
        redirect_to current_user
    end

    private

        def order_params
            params.require(:order).permit(:user, :city, :address, 
                :cvv, :phone, :currency, :zip_code, 
                :card_number, :exp_date, :comment)
        end
end
