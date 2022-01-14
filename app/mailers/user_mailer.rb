class UserMailer < ApplicationMailer

    def purchased(user)
        @user = user
        puts @user.orders.last
        mail to: @user.email, subject: "Hello! You have purchased an order #{@user.orders.last}"
    end
end
