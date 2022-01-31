class OrderItemsController < ApplicationController
    before_action :add_order_item_to_cart, only: [:create]

    def new
        @order_item = OrderItem.new
    end

    def create
        @order_item = OrderItem.new(order_items_params)
        respond_to do |format|
            if @order_item.save
                current_cart.order_items << @order_item
                format.html { redirect_to root_path}
                format.json { render :new, status: :created}
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
            params.require(:order_item).permit(:product_id, :quantity, :cart_id)
        end


        def add_order_item_to_cart
            current_item = OrderItem.find_by_product_id(params[:order_item][:product_id])
            if current_item
                current_item.quantity += params[:order_item][:quantity].to_i
                current_item.save
                redirect_to root_path
            end
        end
end
