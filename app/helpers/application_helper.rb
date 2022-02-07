module ApplicationHelper
  def current_cart
    if current_user.nil?   
      redirect_to new_user_session_path
    elsif !Rails.cache.read(current_user.carts.last&.id).nil?
      @cart = Rails.cache.read(current_user.carts.last.id)
    else
      debugger
      Cart.create(user: current_user, order: nil)
      @cart = Cart.cached_find(current_user)
    end
    @cart
  end
end
