module ApplicationHelper
  def current_cart
    @cache_key = current_user.carts.last&.cache_key_with_version
    redirect_to new_user_session_path if current_user.nil?

    if Rails.cache.read(@cache_key).present?
      @cart = Rails.cache.read(@cache_key)
    else
      current_user.carts.where(:order => nil).destroy_all
      Cart.create(user: current_user, order: nil)
      @cache_key = current_user.carts.last.cache_key_with_version
      @cart = Cart.cached_find(current_user, @cache_key)
    end
    @cart
  end
end
