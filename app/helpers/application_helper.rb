module ApplicationHelper

    def current_cart
        if session[:cart_id] && !current_user.nil?
            @cart ||= Cart.find(session[:cart_id])
        else
            @cart = Cart.create(user: current_user, order: nil)
            session[:cart_id] = @cart.id
        end
        @cart
    end
end
