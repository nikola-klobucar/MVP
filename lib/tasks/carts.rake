namespace :carts do
  desc "Delete one hour old Carts without order_id"
  task delete_1_hour_old: :environment do
    Cart.where(['created_at < ?', 1.hour.ago]).where(order: nil).destroy_all
  end

end
