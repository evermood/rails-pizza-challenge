# This is the main controller to process model Order
#
class OrdersController < ApplicationController

  load_and_authorize_resource

  # GET /orders
  def index
  end

  # GET /orders/1
  def show
  end

  # GET /orders/new
  def new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  def create
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: t('orders.was_created') }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: t('orders.was_updated') }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: t('orders.was_deleted') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  # def set_order
  #   @order = Order.find(params[:id])
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    list = %i[
      state price discount_ids promotion_ids
    ]
    params.require(:order).permit(*list)
  end
end
