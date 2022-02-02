module ApplicationHelper

  def current_cart
    if session[:cart_id] && !current_user.nil?
      begin
        @cart ||= Cart.find(session[:cart_id])
      rescue ActiveRecord::RecordNotFound
        @cart ||= Cart.last
      end
    else
        @cart = Cart.create(user: current_user, order: nil)
        session[:cart_id] = @cart.id
    end
    @cart
  end
end
