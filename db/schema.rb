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

ActiveRecord::Schema[7.0].define(version: 2022_06_04_102401) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "deals", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.bigint "product_id"
    t.bigint "product_size_id"
    t.string "group"
    t.integer "from"
    t.integer "to"
    t.integer "value"
    t.integer "value_scale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_deals_on_code", unique: true
    t.index ["product_id"], name: "index_deals_on_product_id"
    t.index ["product_size_id"], name: "index_deals_on_product_size_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.integer "price_scale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_item_extras", force: :cascade do |t|
    t.bigint "order_item_id", null: false
    t.bigint "extra_id", null: false
    t.string "group"
    t.string "name"
    t.integer "price"
    t.integer "price_scale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["extra_id"], name: "index_order_item_extras_on_extra_id"
    t.index ["order_item_id"], name: "index_order_item_extras_on_order_item_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.uuid "order_id"
    t.bigint "item_id", null: false
    t.string "item_name"
    t.bigint "variant_id", null: false
    t.string "variant_name"
    t.integer "price"
    t.integer "price_scale"
    t.integer "multiplier"
    t.integer "multiplier_scale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["variant_id"], name: "index_order_items_on_variant_id"
  end

  create_table "orders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "state"
    t.string "promotions", default: [], array: true
    t.string "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_sizes", force: :cascade do |t|
    t.string "name"
    t.integer "multiplier"
    t.integer "multiplier_scale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "group"
    t.integer "price"
    t.integer "price_scale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "order_item_extras", "order_items"
end
