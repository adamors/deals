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

ActiveRecord::Schema[7.2].define(version: 20240610) do
  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deals", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.decimal "original_price", precision: 10, scale: 2
    t.decimal "discount_price", precision: 10, scale: 2
    t.integer "discount_percentage"
    t.integer "category_id", null: false
    t.integer "subcategory_id", null: false
    t.integer "merchant_id", null: false
    t.integer "quantity_sold"
    t.date "expiry_date"
    t.boolean "featured_deal"
    t.string "image_url"
    t.text "fine_print"
    t.integer "review_count"
    t.decimal "average_rating", precision: 3, scale: 2
    t.integer "available_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_deals_on_category_id"
    t.index ["merchant_id"], name: "index_deals_on_merchant_id"
    t.index ["subcategory_id"], name: "index_deals_on_subcategory_id"
  end

  create_table "deals_locations", force: :cascade do |t|
    t.integer "deal_id", null: false
    t.integer "location_id", null: false
    t.string "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_deals_locations_on_deal_id"
    t.index ["location_id"], name: "index_deals_locations_on_location_id"
  end

  create_table "deals_tags", force: :cascade do |t|
    t.integer "deal_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_deals_tags_on_deal_id"
    t.index ["tag_id"], name: "index_deals_tags_on_tag_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.float "lat"
    t.float "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "merchants", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "rating", precision: 3, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "deals", "categories"
  add_foreign_key "deals", "categories"
  add_foreign_key "deals", "merchants"
  add_foreign_key "deals", "merchants"
  add_foreign_key "deals", "subcategories"
  add_foreign_key "deals", "subcategories"
  add_foreign_key "deals_locations", "deals"
  add_foreign_key "deals_locations", "deals"
  add_foreign_key "deals_locations", "locations"
  add_foreign_key "deals_locations", "locations"
  add_foreign_key "deals_tags", "deals"
  add_foreign_key "deals_tags", "deals"
  add_foreign_key "deals_tags", "tags"
  add_foreign_key "deals_tags", "tags"
  add_foreign_key "subcategories", "categories"
  add_foreign_key "subcategories", "categories"
end
