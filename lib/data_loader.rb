module DataLoader
  def self.load_data_from_file(file_path)
    JSON.parse(File.read(file_path))
  end

  def self.update_orders(file_path, orders)
    File.open(file_path, 'w') do |file|
      file.write(JSON.pretty_generate(orders))
    end
  end
end
