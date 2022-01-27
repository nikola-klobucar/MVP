class CartsController < ApplicationController

    def show
        if user_signed_in?
            @order_items = OrderItem.all
        else
            redirect_to new_user_session_path
        end
    end
end
