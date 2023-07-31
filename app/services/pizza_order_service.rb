class PizzaOrderService
  def initialize(config_data)
    @selectable_pizzas = config_data['pizzas']
    @multipliers = config_data['size_multipliers']
    @ingredients = config_data['ingredients']
    @promotion_codes = config_data['promotions']
    @discount_codes = config_data['discounts']
  end

  def calculate_total_order_price(items)
    price = 0

    # Calculate the price of each pizza in the order and add it to the total price
    items.each do |item|
      pizza = item['name']
      pizza_size = item['size']
      additional_ingridients = item['add']
      removed_ingridients = item['remove']

      pizza_price = calculate_pizza_price(pizza, pizza_size, additional_ingridients, removed_ingridients)
      price += pizza_price
    end

    # Apply promotion codes to the order price
    apply_promotion_codes(price)

    # Apply discount codes to the order price
    apply_discount_codes(price)

    price
  end

  # Implement the logic to calculate the pizza price
  # based on the pizza's base price, selected size, and extra ingredients
  def calculate_pizza_price(pizza, size, additional_ingridients, _removed_ingridients)
    # Removed ingridients do not change the price as per business requirements
    # TODO: handle possible errors
    base_price = @selectable_pizzas[pizza]
    multiplier = @multipliers[size]

    amount_in_cents = (multiplier * (base_price + ingridients_price(additional_ingridients)) * 100).to_i
    Money.new(amount_in_cents, 'EUR') # TODO: set up configurable currency
  end

  def ingridients_price(ingridients)
    return 0 if ingridients.empty?

    total_price = 0
    ingridients.each do |ingredient|
      price = @ingredients[ingredient]
      total_price += price if price
    end
    total_price
  end

  def apply_promotion_codes(price)
    # TODO: Implement the logic to check and apply promotion codes to the price
  end

  def apply_discount_codes(price)
    # TODO: Implement the logic to calculate the discount amount and apply it to the price
  end
end
