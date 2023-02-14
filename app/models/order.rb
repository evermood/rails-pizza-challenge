class Order < ApplicationRecord
  include Constants
  include Enums::Order

  has_many :order_items, dependent: :destroy
  has_many :order_promotion_codes, dependent: :destroy
  has_many :order_item_adds, through: :order_items
  has_many :order_item_removes, through: :order_items

  def total_price
    total_price = 0

    order_items.each do |item|
      size_multiplier = SIZE_MULTIPLIERS[item.size.to_sym]
      pizza_price = PIZZAS[item.name.to_sym]
      total_price += pizza_price * size_multiplier
      item.order_item_adds.each do |add|
        total_price += INGREDIENTS[add.ingredient.to_sym] * size_multiplier
      end
    end

    order_promotion_codes.each do |promo|
      next unless PROMOTIONS.key?(promo.code.to_sym)

      promo_details = PROMOTIONS[promo.code.to_sym]
      target = promo_details[:target]
      target_size = promo_details[:target_size]
      from = promo_details[:from]
      to = promo_details[:to]

      count = order_items.select { |item| item.name == target && item.size == target_size }.count

      while count >= from
        total_price -= PIZZAS[target.to_sym] * SIZE_MULTIPLIERS[target_size.to_sym] * (from - to)
        count -= from
      end
    end

    if discount_code && DISCOUNTS.key?(discount_code.to_sym)
      discount = DISCOUNTS[discount_code.to_sym][:deduction_in_percent]
      total_price -= (total_price * discount / 100)
    end

    total_price.round(2)
  end
end
