class Payment < ApplicationRecord
    has_one :order

    validates :card_number,
        :length => {
            :is => 16,
            :message => "Card number must be exactly 16 digits long"
        }
    validates :cvv,
    :length => {
        :is => 3,
        :message => "CVV must be exactly 3 digits long"
    }
end
