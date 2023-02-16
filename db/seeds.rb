# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

seeds_data = YAML.load_file Rails.root.join(*%w[db seeds.yml])

translations = seeds_data['translations']

seeds_data['pizzas'].each do |name, price|
  Pizza
    .create_with(price: price)
    .find_or_create_by name: name
end

seeds_data['size_multipliers'].each do |name_en, coefficient|
  name_de = translations['de'][name_en]
  PizzaSize
    .create_with(coefficient: coefficient, name_de: name_de)
    .find_or_create_by name_en: name_en
end
