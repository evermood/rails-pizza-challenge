require 'data_loader'

class OrdersController < ApplicationController
  before_action :load_orders

  # TODO: Better way of configuring data source
  ORDERS_FILE_PATH = Rails.env.test? ? 'spec/fixtures/test_orders_data.json' : 'data/orders.json'

  def index
    @orders
  end

  def complete
    order_id = params[:id]
    @order = @orders.find { |order| order['id'] == order_id }

    # handle the case when order state is already completed
    @order['state'] = 'completed'

    # TODO: handle errors
    update_orders

    render json: @order, status: :ok
  end

  private

  def load_orders
    @orders ||= DataLoader.load_data_from_file(Rails.root.join(ORDERS_FILE_PATH))
  end

  def update_orders
    DataLoader.update_orders(Rails.root.join(ORDERS_FILE_PATH), @orders)
  end
end
