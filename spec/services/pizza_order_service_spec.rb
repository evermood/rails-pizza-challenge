require 'rails_helper'

RSpec.describe PizzaOrderService do
  let(:pizza_order_service) { PizzaOrderService.new(config_data) }
  let(:config_data) { YAML.load_file(Rails.root.join('data', 'config.yml')) }

  describe '#initialize' do
    it 'assigns config data to instance variables' do
      expect(pizza_order_service.instance_variable_get(:@selectable_pizzas)).to eq(config_data['pizzas'])
      expect(pizza_order_service.instance_variable_get(:@multipliers)).to eq(config_data['size_multipliers'])
      expect(pizza_order_service.instance_variable_get(:@ingredients)).to eq(config_data['ingredients'])
      expect(pizza_order_service.instance_variable_get(:@promotion_codes)).to eq(config_data['promotions'])
      expect(pizza_order_service.instance_variable_get(:@discount_codes)).to eq(config_data['discounts'])
    end
  end

  describe '#calculate_pizza_price' do
    subject { pizza_order_service.calculate_pizza_price(pizza, size, additional_ingredients, removed_ingredients) }

    let(:pizza) { 'Tonno' }
    let(:size) { 'Large' }
    let(:additional_ingredients) { [] }
    let(:removed_ingredients) { [] }
    let(:expected_price) { Money.new('1040', 'EUR') } # TODO: change magic numbers to prices calculated with configs

    it 'calculates the price of a pizza using base price and multiplier' do
      expect(subject).to eq(expected_price) # TODO: add shared example
    end

    context 'with extras' do
      let(:pizza) { 'Margherita' }
      let(:additional_ingredients) { %w[Onions Cheese Olives] }
      let(:expected_price) { Money.new('1365', 'EUR') } # TODO: change magic numbers to prices calculated with configs

      it 'adds the additional ingridients to the price with multiplier' do
        expect(subject).to eq(expected_price)
      end

      context 'with removed ingridients' do
        let(:removed_ingredients) { %w[Onions Cheese Olives] }

        it 'does not change the price' do
          expect(subject).to eq(expected_price)
        end
      end
    end
  end

  describe '#ingridients_price' do
    subject { pizza_order_service.ingridients_price(ingridients) }

    let(:ingridients) { %w[Onions Cheese Olives] }
    let(:expected_price) { 5.5 } # TODO: change magic numbers to prices calculated with configs

    it 'calculates the price of all ingridients' do
      expect(subject).to eq(expected_price)
    end

    context 'when no additional ingridients' do
      let(:ingridients) { [] }
      let(:expected_price) { 0 } # TODO: change magic numbers to prices calculated with configs

      it 'calculates the price of all ingridients' do
        expect(subject).to eq(expected_price)
      end
    end
  end

  describe '#calculate_total_order_price' do
    subject { pizza_order_service.calculate_total_order_price(items) }

    let(:items) do
      [
        { 'name' => 'Margherita', 'size' => 'Large', 'add' => %w[Onions Cheese Olives], 'remove' => [] },
        { 'name' => 'Tonno', 'size' => 'Medium', 'add' => [], 'remove' => %w[Onions Olives] },
        { 'name' => 'Margherita', 'size' => 'Small', 'add' => [], 'remove' => [] }
      ]
    end
    let(:expected_price) { Money.new('2515', 'EUR') } # TODO: change magic numbers to prices calculated with configs

    it 'calculates the total price of all pizzas' do
      expect(subject).to eq(expected_price)
    end
  end
end
