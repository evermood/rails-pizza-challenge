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
require 'rails_helper'

describe Order, type: :model do

  subject(:order) { create :order }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to belong_to(:discount).optional}
    it { is_expected.to have_many(:items).dependent(:destroy)}
  end   # validations

  describe 'class methods' do
    describe 'scopes' do
      describe '.open' do
        it 'returns the records of Order that have the value "open" in #state' do
          expect(described_class.open).to eq described_class.where(state: 'open')
        end
      end

      describe '.ordered' do
        it 'orders the records of OrderItem by #created_at' do
          expect(described_class.ordered).to eq described_class.order(:created_at)
        end
      end
    end   # scopes
  end   # class methods

  describe 'before create' do
    context 'when #state is blank' do
      it 'assigns "open" to #state' do
        expect(order.state).to eq "open"
      end
    end

    context 'when #state is present' do
      let(:order) {create :order, state: 'something'}

      it 'does not assign "open" to #state' do
        expect(order.state).to eq "something"
      end
    end
  end

  describe '#complete!' do
    subject(:complete!) {order.complete!}

    it 'changes #state ot "done"' do
      expect{complete!}.to change(order, :state).to "done"
    end

    it 'saves #current_price to #price' do
      expect(order).to receive(:current_price).and_return 65.87
      expect{complete!}.to change(order, :price).to 65.87
    end

    it 'makes the change persistent' do
      complete!
      expect(order.reload.state).to eq "done"
    end
  end

  describe '#current_price' do
    subject(:current_price) {order.current_price}

    it 'calls #base_price' do
      expect(order).to receive(:base_price).and_call_original
      current_price
    end

    it 'calls #extra_price' do
      expect(order).to receive(:extra_price).and_call_original
      current_price
    end

    context 'when #discount is blank' do
      let(:order) {create :order, discount: nil}

      it 'returns the sum of #base_price and #extra_price' do
        is_expected.to eq order.base_price + order.extra_price
      end
    end

    context 'when #discount is present' do
      it 'sends :apply_to to #discount' do
        expect(order.discount).to receive(:apply_to).and_call_original
        current_price
      end

      it 'returns the result of #discount.apply_to' do
        allow(order.discount).to receive(:apply_to).and_return 32.97
        is_expected.to eq 32.97
      end
    end
  end

  describe '#base_price' do
    subject(:base_price) {order.base_price}
    let(:promotions) {order.promotions}
    let(:order) {create :order}
    let(:items) {OrderItem.where order: order}
    let(:item) {create :order_item}

    it 'loops through #promotions' do
      expect(order).to receive(:promotions).and_return promotions
      expect(promotions).to receive(:each_with_object).with([])
          .and_call_original
      base_price
    end

    describe 'for each promotion in #promotions' do
      before do
        #allow(order).to receive(:items).and_return items
      end

      it 'sends :apply_to it with #items with #items' do
        expect_any_instance_of(Promotion).to receive(:apply_to)
          .with(order.items)
          .and_call_original
        base_price
      end

      it 'accumulates the first items of promotion#apply_to calls in the variable fits' do
        allow_any_instance_of(Promotion).to receive(:apply_to)
            .and_return [[5], 5]
        allow(order).to receive(:items).and_return items
        expect_any_instance_of(ActiveRecord::QueryMethods::WhereChain)
            .to receive(:not).with(id: [5] * promotions.count)
            .and_return []
        base_price
      end

      it 'accumulates the last items of promotion#apply_to calls in the variable price' do
        allow_any_instance_of(Promotion).to receive(:apply_to)
            .and_return [[], 15]
        allow(order).to receive(:items).and_return items
        is_expected.to eq 15
      end

      it 'finds the #items wose #id is not in fits' do
        allow_any_instance_of(Promotion).to receive(:apply_to)
            .and_return [[5], 5]
        allow(order).to receive(:items).and_return items
        expect_any_instance_of(ActiveRecord::QueryMethods::WhereChain)
            .to receive(:not).with(id: [5] * promotions.count)
            .and_return []
        base_price
      end

      it 'sends :base_price do each item wose #id is not in fits' do
        allow_any_instance_of(ActiveRecord::QueryMethods::WhereChain)
            .to receive(:not).and_return [item]
        expect(item).to receive(:base_price).and_call_original
        base_price
      end

      it 'returns the sum of accumulated price and the sum of #base_prices of the #items wose #id is not in fits' do
        allow_any_instance_of(Promotion).to receive(:apply_to)
            .and_return [[], 15]
        allow_any_instance_of(ActiveRecord::QueryMethods::WhereChain)
            .to receive(:not).and_return [item]
        is_expected.to eq 15 + item.base_price
      end
    end
  end

  describe 'extra_price' do
    subject(:extra_price) {order.extra_price}
    let(:order) {create :order, :with_items}

    before do
      allow_any_instance_of(OrderItem).to receive(:extra_price)
          .and_return 1.4
    end

    it 'returns the sum of #extra_price of all items' do
      is_expected.to eq 1.4 * 2
    end
  end

  describe '#promotions' do
    subject(:promotions) {order.promotions}

    it 'returns an Array' do
      is_expected.to be_an Array
    end

    it 'has an instanse of promotion in each element' do
      expect(promotions.map(&:class).uniq).to eq [Promotion]
    end
  end

  describe '#promotions=(promotions)' do
    subject(:set_promotions) {order.promotions = promotions}
    let(:promotions) {[promotion1, promotion2]}
    let(:promotion1) {create :promotion}
    let(:promotion2) {create :promotion}
    let(:slugs) {[promotion1.slug, promotion2.slug]}

    it 'updates #promotion_ids with the list of slug of promotions' do
      expect{set_promotions}.to change(order, :promotion_ids).to slugs
    end

    it 'makes the change persistent' do
      set_promotions
      expect(order.reload.promotion_ids).to eq slugs
    end
  end

  describe 'total_price' do
    subject(:total_price) {order.total_price}

    context 'when #price is present' do
      it 'returns #price' do
        is_expected.to be order.price
      end
    end

    context 'when #price is blank' do
      let(:order) {create :order, price: nil}

      it 'calls #current_price' do
        expect(order).to receive :current_price
        total_price
      end

      it 'returns #current_price' do
        allow(order).to receive(:current_price).and_return :current_price
        is_expected.to be :current_price
      end
    end
  end
end
