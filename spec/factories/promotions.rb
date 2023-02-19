# == Schema Information
#
# Table name: promotions
#
#  slug       :string           not null, primary key
#  name       :string
#  pizza_slug :string
#  size_slug  :string
#  from       :integer
#  to         :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :promotion do
    sequence(:name) {|n| "PromotionName#{format '%03d', n}"}
    association :pizza, factory: :pizza
    association :pizza_size, factory: :pizza_size
    from {rand 1..3}
    to {1}
  end
end
