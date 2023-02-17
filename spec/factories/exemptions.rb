# == Schema Information
#
# Table name: exemptions
#
#  id            :bigint           not null, primary key
#  order_item_id :bigint           not null
#  ingredient_id :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_exemptions_on_ingredient_id  (ingredient_id)
#  index_exemptions_on_order_item_id  (order_item_id)
#
FactoryBot.define do
  factory :exemption do
    association :order_item, factory: :order_item
    association :ingredient, factory: :ingredient
  end
end
