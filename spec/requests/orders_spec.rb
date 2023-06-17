# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  subject { response }

  describe 'GET /orders' do
    before do
      create(:order, items: [{ name: 'Salami', size: 'Large' }])
      create(:order, items: [{ name: 'Salami', size: 'Medium' }])
      create(:order, items: [{ name: 'Margherita', size: 'Small' }])
    end

    context 'HTTP Status' do
      it 'should return ok' do
        get orders_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when there are orders' do
      context 'when all orders are open' do
        it 'should show 3 orders' do
          get orders_path
          expect(response.body.scan('Total Price').count).to eq(3)
        end
      end

      context 'when one of the orders is completed' do
        let(:order) { Order.last }

        it 'shouldnt show the completed order' do
          order.update!(state: :completed)
          get orders_path
          expect(response.body.scan('Total Price').count).to eq(2)
        end
      end
    end
  end

  describe 'PATCH /order/:id' do
    let(:params) do
      {
        order: { state: :completed }
      }
    end
    let(:order) { create(:order) }

    it 'should return 302 as HTTP Status' do
      patch order_path(order), params: params
      expect(response).to have_http_status(302)
    end

    it 'should set order to completed' do
      patch order_path(order.id), params: params
      expect(order.reload.state).to eq('completed')
    end
  end
end
