class OrdersController < ApplicationController

    # def index
    #     @orders = current_order
    # end

    def edit
        @order = current_order
    end

    def update
        @order = current_order
        if @order.update(order_params)
            @order.update(currency: CURRENCY[0])
            binding.pry
            redirect_to new_payment_path
        else
            render :edit
        end
      
        
    end

    def show
        @order = current_user.orders.find(params[:id])
    end

    private

        def order_params
            params.require(:order).permit(:user, :city, 
                :address, :phone, :zip_code, :country,
                :comment, :transaction_type,
                :order_info, :order_number, :currency, :payment_id)
        end
end
