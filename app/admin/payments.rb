ActiveAdmin.register Payment do
  permit_params :refund

  controller do

    def edit
      @payment = Payment.find(permitted_params[:id])
      unless @payment.refund
        render :edit
      else
        flash[:notice] = "The product has already been refunded"
        render :show
      end
    end

    def update
      @payment = Payment.find(permitted_params[:id])
      respond_to do |format|
        if @payment.update(permitted_params[:payment])
          format.html { redirect_to admin_payment_path(@payment), notice: "Payment was successfully updated"}
          format.json { render :show, status: :created}
        else
          format.html { render :new }
          format.json { render json: @payment.errors, status: :unprocessable_entity}
        end
      end
    end
  end
  
  index do
    selectable_column
    column :payment_result
    column :refund?
    actions
  end

  form do |f|
    f.inputs :refund
    f.actions
  end
end