class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :edit, :update, :destroy]
    before_action :set_order, only: [:index, :show]

    def index
        @products = Product.all
        @products = @products.search(params[:q].downcase) if params[:q] && !params[:q].empty?
    end

    def show
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params.merge(user: current_user))
        respond_to do |format|
            if @product.save
                format.html { redirect_to @product, notice: "Product was successfully created"}
                format.json { render :show, status: :created}
              else
                format.html { redirect_to new_user_session_path, notice: "You must be signed-in first" }
                format.json { render json: @product.errors, status: :unprocessable_entity}
            end
        end
    end
    
    def edit
    end

    def update
        respond_to do |format|

            if @product.update(product_params)
                format.html { redirect_to @product, notice: "Product was successfully updated"}
                format.json { render :show, status: :created}
              else
                format.html { render :new }
                format.json { render json: @product.errors, status: :unprocessable_entity}
            end
        end
    end

    def destroy
        @product.destroy
        respond_to do |format|
            format.html { redirect_to products_url, notice: "Product was successfully destroyed"}
            format.json { head :no_content}
        end
    end


    private

        def product_params
            params.require(:product).permit(:name, :description, :specs, :product_code, :sold, :price_cents)
        end

        def set_product
            @product = Product.find(params[:id])
        end

        def set_order
            @order_item = current_order.order_items.new
        end
end
