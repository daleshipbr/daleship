# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_31_025754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "freight_id", null: false
    t.date "load_date", null: false
    t.integer "quantity_of_containers", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["freight_id"], name: "index_bookings_on_freight_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "cnpj", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "documents", force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.string "file_url"
    t.boolean "approved"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_id"], name: "index_documents_on_booking_id"
  end

  create_table "freights", force: :cascade do |t|
    t.string "modal", null: false
    t.bigint "origin_port_id", null: false
    t.bigint "destination_port_id", null: false
    t.string "load_type", null: false
    t.string "shipment_type", null: false
    t.string "container_pack", null: false
    t.bigint "user_id", null: false
    t.date "expiration_date", null: false
    t.integer "price_per_container", null: false
    t.string "ship_owner", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["destination_port_id"], name: "index_freights_on_destination_port_id"
    t.index ["origin_port_id"], name: "index_freights_on_origin_port_id"
    t.index ["user_id"], name: "index_freights_on_user_id"
  end

  create_table "ports", force: :cascade do |t|
    t.string "name", null: false
    t.string "zipcode", null: false
    t.string "street", null: false
    t.integer "number", null: false
    t.string "complement"
    t.string "neighborhood"
    t.string "city", null: false
    t.string "state", null: false
    t.string "country", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating", null: false
    t.string "comment"
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_reviews_on_company_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "job_title", null: false
    t.string "user_type", null: false
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone"
    t.string "remenber_digest"
    t.boolean "admin", default: false
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean "accepted_terms_of_service"
    t.datetime "destroyed_at"
    t.index ["company_id"], name: "index_users_on_company_id"
  end

  add_foreign_key "bookings", "freights"
  add_foreign_key "bookings", "users"
  add_foreign_key "documents", "bookings"
  add_foreign_key "freights", "ports", column: "destination_port_id"
  add_foreign_key "freights", "ports", column: "origin_port_id"
  add_foreign_key "freights", "users"
  add_foreign_key "reviews", "companies"
  add_foreign_key "reviews", "users"
  add_foreign_key "users", "companies"
end
