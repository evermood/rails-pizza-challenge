require 'rails_helper'
require 'data_loader'

RSpec.describe 'orders/index', type: :view do
  let(:orders_data) { JSON.parse(File.read(Rails.root.join('spec', 'fixtures', 'test_orders_data.json'))) }

  before do
    assign(:orders, orders_data)
    render
  end

  it 'displays non-completed orders with correct data' do
    assert_select '.order', count: orders_data.count { |order| order['state'].downcase != 'completed' }
    assert_select 'h1', text: 'Orders'

    orders_data.each do |order|
      if order['state'].downcase == 'completed'
        expect(rendered).to_not include("ID: #{order['id']}")
      else
        assert_select 'p', text: "ID: #{order['id']}"
        assert_template partial: 'shared/_date_display', locals: { date: DateTime.parse(order['createdAt']) }
        assert_select 'p', text: "Promotion Codes: #{order['promotionCodes'].empty? ? '-' : order['promotionCodes'].join(', ')}"
        assert_select 'p', text: "Discount Codes: #{order['discountCode'].nil? ? '-' : order['discountCode']}"
        assert_select 'p', text: 'Total price:'

        assert_select 'p', text: 'Items:'
        order['items'].each do |item|
          expect(rendered).to include("#{item['name']} (#{item['size']})")
          assert_template partial: 'shared/ingridients_list', locals: { items: item['add'], action: 'Add' }
          assert_template partial: 'shared/ingridients_list', locals: { items: item['remove'], action: 'Remove' }
        end

        assert_select 'button', text: 'Complete'
        assert_select "button[onclick*=\"completeOrder('#{order['id']}')\"]"
      end
    end
  end

  context 'when there are no non-completed orders' do
  end

  context 'when there are empty orders' do
    let(:orders_data) { [] }

    it 'displays no orders' do
      expect(rendered).to include('Oops, there are no orders to display')
    end
  end
end
