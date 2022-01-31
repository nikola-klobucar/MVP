class CartsController < ApplicationController

    def index
        if user_signed_in?
            @carts = current_cart.order_items.all
        else
            redirect_to new_user_session_path
        end
    end

    def new
        @cart = Cart.new
    end

    def create
        @cart = Cart.new(carts_params)

        respond_to do |format|
            if @cart.save
                format.html { redirect_to root_path}
                format.json { render :show, status: :created}
            else
                format.html { redirect_to new_user_session_path, notice: "You must be signed-in first" }
                format.json { render json: @carts.errors, status: :unprocessable_entity}
            end
        end
    end

    # def delete
    #     @cart = Cart.find(params[:id])
    #     if @cart.order_items = nil
    # end


    private

        def carts_params
            params.require(:cart).permit(:user, :order)
        end
end
