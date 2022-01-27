class OrderItemsController < ApplicationController

    def new
        @order_item = OrderItem.new
    end

    def create
        @order_item = OrderItem.new(order_items_params)
        respond_to do |format|
            if @order_item.save
                format.html { redirect_to root_path}
                format.json { render :show, status: :created}
            else
                format.html { redirect_to new_user_session_path, notice: "You must be signed-in first" }
                format.json { render json: @order_item.errors, status: :unprocessable_entity}
            end
        end
    end

    def update
        @order_item = OrderItem.find(params[:id])

        respond_to do |format|
            if @order_item.update(order_items_params)
                format.html { redirect_to root_path}
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
            params.require(:order_item).permit(:product_id, :quantity)
        end
end
