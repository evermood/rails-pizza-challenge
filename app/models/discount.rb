# == Schema Information
#
# Table name: discounts
#
#  slug                 :string           not null, primary key
#  name                 :string
#  deduction_in_percent :decimal(10, 2)   not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

# Model Discount keeps the discounts that can be applied to Order
#
class Discount < ApplicationRecord

  slug :name
  self.primary_key = :slug

  validates :name, :deduction_in_percent, presence: true
  validates :deduction_in_percent, numericality: {greater_than: 0, less_than: 100}

  scope :ordered, -> { order(:name) }

  def apply_to(price)
    (price * (100 - deduction_in_percent) / 100).round 2
  end
end
