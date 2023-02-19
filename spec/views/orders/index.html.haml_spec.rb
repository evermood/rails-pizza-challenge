require 'rails_helper'

describe "orders/index.html.haml", type: :view do
  let!(:order) {create :order}

  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
    allow(controller).to receive(:params)
        .and_return(ActionController::Parameters.new({}))
    assign :orders, Order.all
  end

  it "renders #id in td.left>ul>li.id" do
    render

    assert_select 'td.left>ul>li.id', text: Regexp.new(order.id.to_s)
  end
end
