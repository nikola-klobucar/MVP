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
        if @payment.execute_refund.status == 200
          @refund = RefundReference.new(response: @payment.execute_refund.body)
          @refund.save
          @payment.update(refund: true, refund_reference: @refund)
          format.html { redirect_to admin_payment_path(@payment), notice: "Payment has been successfully refunded"}
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
    column :refund_reference
    actions
  end

  show do
    attributes_table do
      row :created_at
      row :updated_at
      row :payment_result
      row :refund
      row :refund_reference
      active_admin_comments
    end
  end

  form do |f|
    f.inputs :refund
    f.actions
  end

  action_item :view, only: :show do
    link_to 'Refund', admin_payment_path(payment), method: :patch if payment.refund == false
  end
  
end