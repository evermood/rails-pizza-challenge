require 'data_loader'
require 'json'

RSpec.describe DataLoader do
  FILE_PATH = 'spec/fixtures/orders.json'.freeze

  describe '.load_data_from_file' do
    it 'loads data from the file' do
      data = DataLoader.load_data_from_file(FILE_PATH)
      expect(data).to be_an(Array)
    end
  end

  describe '.update_orders' do
    let(:new_orders) do
      [
        { 'id' => '1', 'name' => 'Updated Order 1' },
        { 'id' => '3', 'name' => 'New Order 3' }
      ]
    end

    it 'updates the orders in the file' do
      DataLoader.update_orders(FILE_PATH, new_orders)

      updated_data = DataLoader.load_data_from_file(FILE_PATH)
      expect(updated_data).to be_an(Array)
      expect(updated_data).to eq(new_orders)
    end
  end
end
