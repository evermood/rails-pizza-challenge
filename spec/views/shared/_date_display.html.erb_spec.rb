RSpec.describe 'shared/_date_display', type: :view do
  it 'displays the formatted date correctly' do
    date = DateTime.new(2023, 7, 31, 13, 44)
    render partial: 'shared/date_display', locals: { date: }

    expect(rendered).to include('July 31, 2023 13:44')
  end
end
