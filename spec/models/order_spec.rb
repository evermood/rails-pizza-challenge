# == Schema Information
#
# Table name: orders
#
#  id            :uuid             not null, primary key
#  state         :string
#  price         :decimal(10, 2)
#  discount_ids  :string           default([]), not null, is an Array
#  promotion_ids :string           default([]), not null, is an Array
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

describe Order, type: :model do

  subject(:order) { create :order }

  describe 'validations' do
    it { is_expected.to be_valid }
  end   # validations

  describe 'before create' do
    it 'assigns "ready" to #state' do
      expect(order.state).to eq "ready"
    end
  end

  describe '#complete!' do
    subject(:complete!) {order.complete!}

    it 'changes #state ot "done"' do
      expect{complete!}.to change(order, :state).to "done"
    end

    it 'makes the change persistent' do
      complete!
      expect(order.reload.state).to eq "done"
    end
  end

  describe '#discounts' do
    subject(:discounts) {order.discounts}

    it 'returns an Array' do
      is_expected.to be_an Array
    end

    it 'has an instanse of Discount in each element' do
      expect(discounts.map(&:class).uniq).to eq [Discount]
    end
  end

  describe '#discounts=(discounts)' do
    subject(:set_discounts) {order.discounts = discounts}
    let(:discounts) {[discount1, discount2]}
    let(:discount1) {create :discount}
    let(:discount2) {create :discount}
    let(:slugs) {[discount1.slug, discount2.slug]}

    it 'updates #discount_ids with the list of slug of discounts' do
      expect{set_discounts}.to change(order, :discount_ids).to slugs
    end

    it 'makes the change persistent' do
      set_discounts
      expect(order.reload.discount_ids).to eq slugs
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
end
