class Cart < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :user

  has_many :order_items, dependent: :destroy

  def self.cached_find(current_user)
    Rails.cache.fetch(current_user.carts.last.id, expires_in: 5.minutes) {find(current_user.carts.last.id)}
  end
end
