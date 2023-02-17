require 'rails_helper'

describe "orders/show.html.haml", type: :view do
  let(:order) {create :order}

  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
    assign :order, order
  end

  it "renders attributes in dl>dd" do
    render
    assert_select 'dl>dd.state', text: Regexp.new(order.state.to_s)
    assert_select 'dl>dd.price', text: Regexp.new(order.price.to_s)
    assert_select 'dl>dd.discount_id', text: Regexp.new(order.discount_id.to_s)
    assert_select 'dl>dd.promotion_ids', text: Regexp.new(order.promotion_ids.to_s)
  end
end
