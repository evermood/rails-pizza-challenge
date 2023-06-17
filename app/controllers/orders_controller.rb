# frozen_string_literal: true

# OrderController
class OrdersController < ApplicationController
  before_action :set_order, only: [:update]

  def index
    @orders = Order.where(state: :open).order(created_at: :asc)
  end

  def update
    @order.update(update_order_params)

    redirect_to orders_path
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def update_order_params
    params.require(:order).permit(:state)
  end
end
