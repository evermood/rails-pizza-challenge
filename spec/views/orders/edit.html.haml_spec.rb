require 'rails_helper'

describe "orders/edit.html.haml", type: :view do
  let(:order) {create :order}

  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
    assign(:order, order)
  end

  it "renders the edit order form" do
    render

    assert_select "form[action='#{order_path(order)}'][method='post']" do
      assert_select 'input#order_state[name=?]', 'order[state]'
      assert_select 'input#order_price[name=?]', 'order[price]'
      assert_select 'input#order_discount_id[name=?]', 'order[discount_id]'
      assert_select 'input#order_promotion_ids[name=?]', 'order[promotion_ids]'
    end
  end
end
