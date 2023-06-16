# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

orders = JSON.parse(File.read('data/orders.json'))

orders.each do |order|
  formatted_order = order.transform_keys(&:underscore)
  formatted_order['state'] = formatted_order['state'].downcase
  Order.create(formatted_order)
end
