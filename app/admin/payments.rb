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
        if @payment.validate_successful_refund
          @payment.update(permitted_params[:payment])
          format.html { redirect_to admin_payment_path(@payment), notice: "Payment was successfully updated"}
          format.json { render :show, status: :updated}
        else
          format.html { render :edit}
          format.json { render json: @payment.errors.full_messages, status: :unprocessable_entity}
          flash.now[:notice] = "Refund has been unsuccessful"
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