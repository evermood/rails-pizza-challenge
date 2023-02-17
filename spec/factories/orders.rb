# == Schema Information
#
# Table name: orders
#
#  id            :uuid             not null, primary key
#  state         :string
#  price         :decimal(10, 2)
#  promotion_ids :string           default([]), not null, is an Array
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  discount_id   :string
#
FactoryBot.define do
  factory :order do
    price { rand(8.0..55.99) }
    association :discount, factory: :discount
    promotion_ids do
      rand(1..2).times.map do
        create(:promotion).slug
      end
    end
  end
end
