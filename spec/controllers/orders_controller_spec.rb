require 'rails_helper'
require 'data_loader'

RSpec.describe OrdersController, type: :controller do
  let(:test_data_file_path) { Rails.root.join('spec/fixtures/test_orders_data.json') }
  let(:test_orders) { DataLoader.load_data_from_file(test_data_file_path) }

  describe 'GET #index' do
    before do
      allow(DataLoader).to receive(:load_data_from_file).and_return(test_orders)
      get :index
    end

    it 'assigns all orders to @orders' do
      expect(assigns(:orders)).to be_an(Array)
      expect(assigns(:orders)).not_to be_empty
      test_orders.each do |order|
        expect(assigns(:orders)).to include(order)
      end
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'PATCH #complete' do
    # TODO: data setup needs to be independant to avoid flakiness
    let(:order_to_complete) { test_orders[0] }
    let(:order_id) { order_to_complete['id'] }

    before do
      patch :complete, params: { id: order_id }
    end

    # TODO
    it 'calls the persistence layer to save updated orders' do
    end

    it 'renders the updated order as JSON' do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(order_to_complete)
    end
  end
end
