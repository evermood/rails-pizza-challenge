# == Schema Information
#
# Table name: order_items
#
#  id              :bigint           not null, primary key
#  order_id        :uuid             not null
#  pizza_slug      :string           not null
#  pizza_size_slug :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :order_item do
    association :order, factory: :order
    association :pizza, factory: :pizza
    association :pizza_size, factory: :pizza_size
  end
end
