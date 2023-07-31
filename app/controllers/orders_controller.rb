require 'data_loader'

class OrdersController < ApplicationController
  before_action :load_orders
  before_action :calculate_order_price, only: :index

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

  # Preload orders from json file
  def load_orders
    @orders ||= DataLoader.load_data_from_file(Rails.root.join(ORDERS_FILE_PATH))
  end

  # Update file with new orders
  def update_orders
    DataLoader.update_orders(Rails.root.join(ORDERS_FILE_PATH), @orders)
  end

  # TODO: after that persist the data and make sure we can pull prices from file correctly
  def calculate_order_price
    # TODO: handle possible errors
    pizza_order_service = PizzaOrderService.new(config_data)
    @orders.each do |order|
      order['totalPrice'] = pizza_order_service.calculate_total_order_price(order['items'])
    end
  end

  # Load the data from data/config.yml and return the relevant information
  def config_data
    @config_data ||= YAML.load_file(Rails.root.join('data', 'config.yml'))
  end
end
