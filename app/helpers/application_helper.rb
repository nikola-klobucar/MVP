module ApplicationHelper

  def cache_key
    @cache_key = current_user.carts.last&.cache_key_with_version
  end

  def payment_present?
    current_user.carts.last.order&.payment.present?
  end

  def current_cart
    redirect_to new_user_session_path if current_user.nil?

    if cache_key.nil? || payment_present?
      current_user.carts.where(:order => nil).destroy_all
      Cart.create(user: current_user, order: nil)
    end
    @cart = Cart.cached_find(current_user, cache_key)
  end
end
