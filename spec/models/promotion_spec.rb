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
require 'rails_helper'

describe Promotion, type: :model do

  subject(:promotion) { create :promotion }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of :name}
    it { is_expected.to validate_presence_of :from}
    it { is_expected.to validate_presence_of :to}
    it { is_expected.to validate_numericality_of(:from).is_greater_than 0}
    it { is_expected.to validate_numericality_of(:to).is_greater_than 0}
  end   # validations

  describe 'class methods' do
    describe 'scopes' do
      describe '.ordered' do
        it 'orders the records of Promotion by :name' do
          expect(Promotion.ordered).to eq Promotion.order(:name)
        end
      end   # .ordered
    end   # scopes
  end   # class methods

  describe '#apply_to(items)' do
    subject(:apply_to) {promotion.apply_to items}
    let(:order) {create :order}
    let(:items) {order.items}
    let(:fits) {[]}

    before do
      (promotion.from * 2 + 1).times do
        create :order_item, order: order,
            pizza: promotion.pizza,
            pizza_size: promotion.pizza_size
      end
      allow(items).to receive(:that_fit).and_return fits
    end

    it 'sends :that_fit to items with #pizza and #pizza_size' do
      expect(items).to receive(:that_fit)
          .with(promotion.pizza, promotion.pizza_size)
          .and_return fits
      apply_to
    end

    context 'when items.that_fit is empty' do
      it 'returns a pair of an empty Array and 0' do
        is_expected.to eq [[], 0]
      end
    end

    context 'when items.that_fit is present' do
      let(:fits) {items}

      it 'sends :base_price to one of item of items.that_fit' do
        expect_any_instance_of(OrderItem).to receive(:base_price)
            .and_call_original
        apply_to
      end

      it 'returns a pair' do
        is_expected.to be_an Array
        expect(apply_to.size).to be 2
      end

      describe 'the first item of the pair' do
        subject(:first_item) {apply_to.first}

        it 'is an Array' do
          is_expected.to be_an Array
        end

        it 'contains the ids of the instances of items that were returned by items.that_fit' do
          expect(first_item.map(&:class).uniq).to eq [Integer]
          expect(first_item.last).to eq fits.last.id
        end

        it 'has the size that is a multiple of #from' do
          expect(first_item.size % promotion.from).to be 0
        end
      end

      describe 'the last item of the pair' do
        subject(:first_item) {apply_to.first}
        subject(:last_item) {apply_to.last}

        it 'is a Numeric' do
          is_expected.to be_a Numeric
        end

        it 'is equal to the size of the first item divided by #from mutipied by #to and mutipied by the obtained OrderItem#base_price' do
          is_expected.to eq first_item.size / promotion.from * promotion.to *
              fits.first.base_price
        end
      end
    end
  end
end
