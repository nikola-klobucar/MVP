module ApplicationHelper

  # def current_cart
  #   if !Cart.all.empty? && !current_user.nil? 
  #     begin
  #       Cart.find(session[:cart_id])
  #     rescue ActiveRecord::RecordNotFound
  #       if !Rails.cache.read(session[:cart_id]).nil?
  #         binding.pry
  #         Rails.cache.read(session[:cart_id])
  #       else
  #         binding.pry
  #         @cart = Cart.create(user: current_user, order: nil)
  #         session[:cart_id] = @cart.id
  #         Cart.cached_find(session[:cart_id])
  #       end
  #     end
  #   else
  #     session[:cart_id] = nil
  #     @cart = Cart.create(user: current_user, order: nil)
  #     session[:cart_id] = @cart.id
  #     Cart.cached_find(session[:cart_id])
  #   end
  # end



  def current_cart
    if current_user.nil?   
      redirect_to new_user_session_path
    elsif !Cart.all.empty? && !Rails.cache.read(current_user.carts.last.id).nil?
      @cart = Rails.cache.read(current_user.carts.last.id)
    else
      Cart.create(user: current_user, order: nil)
      @cart = Cart.cached_find(current_user)
    end
    @cart
  end
end
