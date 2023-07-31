RSpec.describe 'shared/_ingridients_list', type: :view do
  context 'when items are present' do
    let(:items) { %w[Mushrooms Ananas Thyme] }
    let(:action) { 'Pack' }

    before do
      render partial: 'shared/ingridients_list', locals: { items:, action: }
    end

    it 'displays the items correctly' do
      assert_select 'ul' do
        assert_select 'li', text: "#{action}: #{items.join(', ')}"
      end
    end
  end

  context 'when items are empty' do
    let(:items) { [] }

    it 'does not display the items section' do
      assert_select 'ul', count: 0
    end
  end
end
