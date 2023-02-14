class OrderPromotionCode < ApplicationRecord
  belongs_to :order

  validates :order, presence: true
  validates :code, presence: true
end
