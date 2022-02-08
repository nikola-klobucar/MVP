module ApplicationHelper
  def current_cart
    @cache_key = current_user.carts.last&.cache_key_with_version
    if current_user.nil?   
      redirect_to new_user_session_path
    elsif !Rails.cache.read(@cache_key).nil?
      @cart = Rails.cache.read(@cache_key)
    else
      Cart.create(user: current_user, order: nil)
      @cache_key = current_user.carts.last.cache_key_with_version
      @cart = Cart.cached_find(current_user, @cache_key)
    end
    @cart
  end
end
