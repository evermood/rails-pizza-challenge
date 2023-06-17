# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'has a valid factory' do
    expect(build(:order)).to be_valid
  end

  describe '#total_price' do
    context 'when order has no promotion or discount code' do
      context 'and has no added or removed ingredient' do
        let(:order) { create(:order, items: [{ name: 'Salami', size: 'Large' }]) }

        it 'returns correct price' do
          expect(order.total_price).to eq(7.8)
        end
      end

      context 'and has one ingredient added' do
        context 'and size is Small' do
          let(:order) { create(:order, items: [{ name: 'Salami', size: 'Small', add: %w[Onions] }]) }

          it 'returns correct price' do
            expect(order.total_price).to eq(4.9)
          end
        end

        context 'and size is Medium' do
          let(:order) { create(:order, items: [{ name: 'Salami', size: 'Medium', add: %w[Olives] }]) }

          it 'returns correct price' do
            expect(order.total_price).to eq(8.5)
          end
        end

        context 'and size is Large' do
          let(:order) { create(:order, items: [{ name: 'Salami', size: 'Large', add: %w[Cheese] }]) }

          it 'returns correct price' do
            expect(order.total_price).to eq(10.4)
          end
        end
      end

      context 'and has more than one ingredients added' do
        context 'and size is Small' do
          let(:order) { create(:order, items: [{ name: 'Salami', size: 'Small', add: %w[Onions Cheese] }]) }

          it 'returns correct price' do
            expect(order.total_price).to eq(6.3)
          end
        end

        context 'and size is Medium' do
          let(:order) { create(:order, items: [{ name: 'Salami', size: 'Medium', add: %w[Olives Onions] }]) }

          it 'returns correct price' do
            expect(order.total_price).to eq(9.5)
          end
        end

        context 'and size is Large' do
          let(:order) { create(:order, items: [{ name: 'Salami', size: 'Large', add: %w[Cheese Olives] }]) }

          it 'returns correct price' do
            expect(order.total_price).to eq(13.65)
          end
        end
      end

      context 'and has ingredient removed' do
        let(:order) { create(:order, items: [{ name: 'Salami', size: 'Medium', remove: %w[Onions Cheese] }]) }

        it 'should not alter price' do
          expect(order.total_price).to eq(6)
        end
      end
    end

    context 'when order has promotion code' do
      context 'and has no added or removed ingredient' do
        let(:items) do
          [
            {
              name: 'Salami',
              size: 'Small'
            },
            {
              name: 'Salami',
              size: 'Small'
            }
          ]
        end
        let(:order) { create(:order, items: items, promotion_codes: %w[2FOR1]) }

        it 'should return for 1 pizza (2FOR1 code)' do
          expect(order.total_price).to eq(4.2)
        end
      end

      context 'and has added ingredients' do
        let(:items) do
          [
            {
              name: 'Salami',
              size: 'Small',
              add: %w[Onions]
            },
            {
              name: 'Salami',
              size: 'Small'
            }
          ]
        end
        let(:order) { create(:order, items: items, promotion_codes: %w[2FOR1]) }

        it 'should return promotion + item price for size' do
          expect(order.total_price).to eq(4.9)
        end
      end

      context 'and has no promotion items on order' do
        let(:items) do
          [
            {
              name: 'Margherita',
              size: 'Large',
              add: %w[Onions]
            },
            {
              name: 'Tonno',
              size: 'Small'
            }
          ]
        end
        let(:order) { create(:order, items: items, promotion_codes: %w[2FOR1]) }

        it 'should return promotion + item price for size' do
          expect(order.total_price).to eq(13.4)
        end
      end
    end

    context 'when order has discount code' do
      context 'and has no added or removed ingredient' do
        let(:items) do
          [
            {
              name: 'Margherita',
              size: 'Large'
            },
            {
              name: 'Tonno',
              size: 'Small'
            }
          ]
        end
        let(:order) { create(:order, items: items, discount_code: 'SAVE5') }

        it 'should return discount on total price (SAVE5 code)' do
          expect(order.total_price).to eq(12.1)
        end
      end

      context 'and has added ingridients' do
        let(:items) do
          [
            {
              name: 'Margherita',
              size: 'Large',
              add: %w[Onions]
            },
            {
              name: 'Tonno',
              size: 'Small'
            }
          ]
        end
        let(:order) { create(:order, items: items, discount_code: 'SAVE5') }

        it 'should return discount on total price (SAVE5 code)' do
          expect(order.total_price).to eq(13.4)
        end
      end
    end
  end
end
