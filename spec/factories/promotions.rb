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
    sequence(:name) {|n| "Name#{format '%03d', n}" }
    association :pizza, factory: :pizza
    association :pizza_size, factory: :pizza_size
    sequence(:from) {|n| "1#{format '%03d', n}" }
    sequence(:to) {|n| "2#{format '%03d', n}" }
  end
end
