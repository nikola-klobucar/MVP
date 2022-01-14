class CartsController < ApplicationController

    def show
        if user_signed_in?
            @order_items = current_order.order_items
        else
            redirect_to new_user_session_path
        end
    end
end
