class Payment < ApplicationRecord
    has_one :order, dependent: :destroy
end
