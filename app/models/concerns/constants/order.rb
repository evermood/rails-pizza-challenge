module Order::Constants
  SIZE_MULTIPLIERS = {
    Small: 0.7,
    Medium: 1,
    Large: 1.3
  }

  PIZZAS = {
    Margherita: 5,
    Salami: 6,
    Tonno: 8
  }

  INGREDIENTS = {
    Onions: 1,
    Cheese: 2,
    Olives: 2.5
  }

  PROMOTIONS = {
    '2FOR1': {
      target: 'Salami',
      target_size: 'Small',
      from: 2,
      to: 1
    }
  }

  DISCOUNTS = {
    'SAVE5': {
      deduction_in_percent: 5
    }
  }
end
