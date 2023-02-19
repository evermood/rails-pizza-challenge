require 'rails_helper'

describe "orders/show.html.haml", type: :view do
  let(:order) {create :order}

  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
    assign :order, order
  end

  it "renders #id in td.left>ul>li.id" do
    render

    assert_select 'td.left>ul>li.id', text: Regexp.new(order.id.to_s)
  end
end
