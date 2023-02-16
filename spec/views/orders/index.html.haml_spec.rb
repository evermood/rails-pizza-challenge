require 'rails_helper'

describe "orders/index.html.haml", type: :view do
  let!(:order) {create :order}

  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
    allow(controller).to receive(:params)
        .and_return(ActionController::Parameters.new({}))
    assign :orders, Order.all
  end

  it "renders a list of orders" do
    render

    assert_select 'tr>td.state', text: order.state.to_s, count: 1
    assert_select 'tr>td.price', text: order.price.to_s, count: 1
    #assert_select 'tr>td.discount_ids', text: order.discount_ids.to_s, count: 1
    #assert_select 'tr>td.promotion_ids', text: order.promotion_ids.to_s, count: 1
  end

end
