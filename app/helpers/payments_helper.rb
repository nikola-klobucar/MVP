module PaymentsHelper
    def current_order
        if !session[:order_number].nil? && !Order.all.empty?
            Order.find_by_order_number(session[:order_number])
        else
            Order.new
        end
    end
end
