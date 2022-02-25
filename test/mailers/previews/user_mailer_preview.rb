# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def purchased
        user = User.first
        UserMailer.purchased(user)
    end
end
