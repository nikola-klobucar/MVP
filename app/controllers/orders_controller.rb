class OrdersController < ApplicationController

    def new
        @order = Order.new
    end

    def create
        @order = Order.new(order_params)
        @order.user = current_user
        @order.currency = CURRENCY
        @order.order_items << OrderItem.all   # Moram napraviti Cart model
        respond_to do |format|
            if @order.save
                session[:order_number] = @order.order_number
                format.html { redirect_to new_payment_path}
                format.json { render :show, status: :created}
              else
                format.html { redirect_to root_path, notice: "Something went wrong." }
                format.json { render json: @order.errors, status: :unprocessable_entity}
            end
        end
        
    end

    def show
        @order = current_user.orders.find(params[:id])
    end

    # def edit
    # end

    # def update
    #     binding.pry
    #     if @order.update(order_params)
    #         @order.update(currency: CURRENCY)
    #         redirect_to new_payment_path
    #     else
    #         render :edit
    #     end
      
        
    # end

    private

        def order_params
            params.require(:order).permit(:user, :city, 
                :address, :phone, :zip_code, :country,
                :comment, :transaction_type,
                :order_info, :order_number, :currency, :payment_id)
        end
end
