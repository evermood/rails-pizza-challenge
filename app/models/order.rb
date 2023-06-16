# frozen_string_literal: true

# Order model
class Order < ApplicationRecord
  enum state: { open: 'open', completed: 'completed' }

  def total_price
    calculate_total_price
  end

  private

  def calculate_total_price
    total = 0

    items.each do |item|
      total += calculate_unit_price(item)
    end

    total -= applied_promotions_price

    total -= (total * applied_discounts_percentage)

    total.round(2)
  end

  def calculate_unit_price(item)
    base_price = CONFIG['pizzas'][item['name']]
    size_multiplier = CONFIG['size_multipliers'][item['size']]

    item['add'].each do |added|
      base_price += CONFIG['ingredients'][added]
    end

    base_price * size_multiplier
  end

  def applied_promotions_price
    return 0 unless promotion_codes.present?

    promotion_discount_price = 0

    promotion_codes.each do |code|
      promotion = CONFIG['promotions'][code]

      count_on_promotion = items_on_promotion(promotion['target'], promotion['target_size']).count

      next unless count_on_promotion > promotion['from']

      times_applied = count_on_promotion / promotion['from']
      items_discounted = promotion['from'] - promotion['to']
      base_price = CONFIG['pizzas'][promotion['target']] * CONFIG['size_multipliers'][promotion['target_size']]

      promotion_discount_price += base_price * times_applied * items_discounted
    end

    promotion_discount_price
  end

  def items_on_promotion(target, target_size)
    items.select do |item|
      item['name'] == target && item['size'] == target_size
    end
  end

  def applied_discounts_percentage
    return 0 unless discount_code.present?

    # As the orders.json file sets the discount_code as a string instead of array,
    # I am applying just one discount code. This would be my code in case of
    # multiple codes:

    # total_percentage = 0
    # discount_code.each do |code|
    #   total_percentage += CONFIG['discounts'][code]['deduction_in_percent']
    # end

    (CONFIG['discounts'][discount_code]['deduction_in_percent']).to_f / 100
  end
end
