Order.destroy_all
OrderItem.destroy_all
OrderItemAdd.destroy_all
OrderItemRemove.destroy_all
OrderPromotionCode.destroy_all

def add_order(order)
  new_order = Order.create!(state: order[:state], discount_code: order[:discountCode])

  order[:items].each do |item|
    new_item = new_order.order_items.create!(name: item[:name], size: item[:size])

    item[:add].each do |add|
      new_item.order_item_adds.create!(ingredient: add)
    end

    item[:remove].each do |remove|
      new_item.order_item_removes.create!(ingredient: remove)
    end
  end

  order[:promotionCodes].each do |code|
    new_order.order_promotion_codes.create!(code: code)
  end
end

orders = [
  {
    id: '316c6832-e038-4599-bc32-2b0bf1b9f1c1',
    state: 'OPEN',
    createdAt: '2021-04-14T11:16:00Z',
    items: [
      {
        name: 'Tonno',
        size: 'Large',
        add: [],
        remove: []
      }
    ],
    promotionCodes: [],
    discountCode: nil
  },
  {
    id: 'f40d59d0-48bd-409a-ac7b-54a1b47f6680',
    state: 'OPEN',
    createdAt: '2021-04-14T13:17:25Z',
    items: [
      {
        name: 'Margherita',
        size: 'Large',
        add: %w[Onions Cheese Olives],
        remove: []
      },
      {
        name: 'Tonno',
        size: 'Medium',
        add: [],
        remove: %w[Onions Olives]
      },
      {
        name: 'Margherita',
        size: 'Small',
        add: [],
        remove: []
      }
    ],
    promotionCodes: [],
    discountCode: nil
  },
  {
    id: '9232679d-e3fd-40bd-81f4-7114ea96e420',
    state: 'OPEN',
    createdAt: '2021-04-14T14:08:47Z',
    items: [
      {
        name: 'Salami',
        size: 'Medium',
        add: ['Onions'],
        remove: ['Cheese']
      },
      {
        name: 'Salami',
        size: 'Small',
        add: [],
        remove: []
      },
      {
        name: 'Salami',
        size: 'Small',
        add: [],
        remove: []
      },
      {
        name: 'Salami',
        size: 'Small',
        add: [],
        remove: []
      },
      {
        name: 'Salami',
        size: 'Small',
        add: ['Olives'],
        remove: []
      }
    ],
    promotionCodes: ['2FOR1'],
    discountCode: 'SAVE5'
  }
]

orders.each do |order|
  add_order(order)
end
