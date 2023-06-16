# frozen_string_literal: true

# OrderController
class OrdersController < ApplicationController
  before_action :set_order, only: [:update]

  def index
    @orders = Order.where(state: :open).order(created_at: :desc)
  end

  def update
    @order.update(state: :open)

    redirect_to orders_index_path
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
