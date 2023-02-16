# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_16_122912) do
  create_table "ingredients", id: false, force: :cascade do |t|
    t.string "slug", null: false
    t.string "name_de"
    t.string "name_en"
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pizza_sizes", id: false, force: :cascade do |t|
    t.string "slug", null: false
    t.string "name_de"
    t.string "name_en"
    t.decimal "coefficient", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pizzas", id: false, force: :cascade do |t|
    t.string "slug", null: false
    t.string "name"
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_pizzas_on_slug", unique: true
  end

  create_table "promotions", id: false, force: :cascade do |t|
    t.string "slug", null: false
    t.string "name"
    t.string "pizza_slug"
    t.string "size_slug"
    t.integer "from"
    t.integer "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
