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
require 'rails_helper'

describe OrderItem, type: :model do

  subject(:order_item) { create :order_item }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to belong_to :order}
    it { is_expected.to belong_to :pizza}
    it { is_expected.to belong_to :pizza_size}
    it { is_expected.to have_many :additions}
    it { is_expected.to have_many :exemptions}
  end   # validations

  describe 'class methods' do
    describe 'scopes' do
      describe '.ordered' do
        it 'orders the records of OrderItem by #created_at' do
          expect(OrderItem.ordered).to eq OrderItem.order(:created_at)
        end
      end   # .ordered
    end   # scopes
  end   # class methods

  describe '#base_price' do
    subject(:base_price) {order_item.base_price}

    it 'returns the price of the pizza multiplied by the coefficient of pizza_size' do
      is_expected.to eq order_item.pizza.price * order_item.pizza_size.coefficient
    end
  end

  describe '#extra_price' do
    subject(:extra_price) {order_item.extra_price}

    it 'returns the sum of the prices of all the ingredients in additions multiplied by the coefficient of pizza_size' do
      addition1 = create :addition, order_item: order_item
      addition2 = create :addition, order_item: order_item
      expect(order_item.additions).to eq [addition1, addition2]
      is_expected.to eq (addition1.ingredient.price + addition2.ingredient.price) *
          order_item.pizza_size.coefficient
    end
  end
end
