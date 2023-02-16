require 'rails_helper'

describe "orders/new.html.haml", type: :view do
  let(:order) {build :order}

  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
    assign(:order, order)
  end

  it "renders new order form" do
    render

    assert_select "form[action='#{orders_path}'][method='post']" do
      assert_select 'input#order_state[name=?]', 'order[state]'
      assert_select 'input#order_price[name=?]', 'order[price]'
      assert_select 'input#order_discount_ids[name=?]', 'order[discount_ids]'
      assert_select 'input#order_promotion_ids[name=?]', 'order[promotion_ids]'
    end
  end
end
