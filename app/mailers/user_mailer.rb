class UserMailer < ApplicationMailer
    
    def purchased(current_user)
        @user = current_user
        mail to: @user["email"], subject: "Hello! You have purchased an order #{@user.orders.last}"
    end
end
