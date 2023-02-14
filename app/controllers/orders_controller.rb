class OrdersController < ApplicationController
  def index
    @orders = Order.includes(:order_items, :order_item_adds, :order_item_removes, :order_promotion_codes)
                    .where(state: :OPEN)
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(state: 'COMPLETE')
      redirect_to @order, notice: 'Order state updated to complete'
    else
      render :show
    end
  end
end
