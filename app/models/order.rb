# == Schema Information
#
# Table name: orders
#
#  id            :uuid             not null, primary key
#  state         :string
#  price         :decimal(10, 2)
#  discount_ids  :string           default([]), not null, is an Array
#  promotion_ids :string           default([]), not null, is an Array
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# Model Order keeps all the pizza orders
#
class Order < ApplicationRecord
  before_create :set_ready! #FIXME: Install AASM

  def complete!
    update state: 'done'
  end

  def discounts
    discount_ids.map do |slug|
      Discount.find slug
    end
  end

  def discounts=(discounts)
    update discount_ids: discounts.map(&:slug)
  end

  def promotions
    promotion_ids.map do |slug|
      Promotion.find slug
    end
  end

  def promotions=(promotions)
    update promotion_ids: promotions.map(&:slug)
  end

  private

  def set_ready!
    self.state = "ready"
  end
end
