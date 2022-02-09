class OrderItemsController < ApplicationController
    include OrderItemsHelper

    def new
        @order_item = OrderItem.new
    end

    def create
        respond_to do |format|
            if save_new_or_existing_order_item(order_items_params)
                format.html { redirect_to root_path}
                format.json { render :new, status: :created}
            else
                format.html { redirect_to new_user_session_path, notice: "You must be signed-in first" }
                format.json { render json: @order_item.errors, status: :unprocessable_entity}
            end
        end
    end

    def update
        respond_to do |format|
            if update_existing_order_item(order_items_params)
                format.html { redirect_to root_path}
                format.json { render :edit, status: :updated}
            else
                format.html { redirect_to new_user_session_path, notice: "You must be signed-in first" }
                format.json { render json: @order_item.errors, status: :unprocessable_entity}
            end
        end
    end

    def destroy
        @order_item = OrderItem.find(params[:id])

        @order_item.destroy
        respond_to do |format|
            format.html { redirect_to carts_url, notice: "Order Item was successfully destroyed"}
            format.json { head :no_content}
        end
    end


    private
        def order_items_params
            params.require(:order_item).permit(:product_id, :quantity, :cart_id)
        end
end
