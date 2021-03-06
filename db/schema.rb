# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_01_30_100513) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.string "pnr"
    t.integer "user_id"
    t.integer "flight_assignment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "net_payble", default: 0.0
    t.integer "seat_category_id"
  end

  create_table "flight_assignments", force: :cascade do |t|
    t.bigint "flight_id"
    t.time "arrival_time"
    t.date "arrival_date"
    t.time "departure_time"
    t.date "departure_date"
    t.float "base_fare"
    t.string "travel_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "source_id"
    t.string "destination_id"
    t.string "slug"
    t.integer "total_first_seat", default: 0
    t.integer "remaining_first_seat", default: 0
    t.integer "total_economy_seat", default: 0
    t.integer "remaining_economy_seat", default: 0
    t.integer "total_business_seat", default: 0
    t.integer "remaining_business_seat", default: 0
    t.text "seat_booked_ids", default: [], array: true
    t.index ["flight_id"], name: "index_flight_assignments_on_flight_id"
    t.index ["slug"], name: "index_flight_assignments_on_slug", unique: true
  end

  create_table "flight_configurations", force: :cascade do |t|
    t.bigint "seat_category_id"
    t.integer "number_of_row"
    t.integer "seat_in_row"
    t.float "seat_base_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seat_category_id"], name: "index_flight_configurations_on_seat_category_id"
  end

  create_table "flight_seat_configurations", force: :cascade do |t|
    t.bigint "flight_id"
    t.bigint "flight_configuration_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_configuration_id"], name: "index_flight_seat_configurations_on_flight_configuration_id"
    t.index ["flight_id"], name: "index_flight_seat_configurations_on_flight_id"
  end

  create_table "flight_seats", force: :cascade do |t|
    t.bigint "flight_seat_configuration_id"
    t.bigint "flight_id"
    t.string "pnr"
    t.float "seat_base_price"
    t.integer "row_number"
    t.integer "seat_number"
    t.string "seat_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_id"], name: "index_flight_seats_on_flight_id"
    t.index ["flight_seat_configuration_id"], name: "index_flight_seats_on_flight_seat_configuration_id"
  end

  create_table "flight_source_destinations", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flights", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["code"], name: "index_flights_on_code", unique: true
    t.index ["name"], name: "index_flights_on_name", unique: true
    t.index ["slug"], name: "index_flights_on_slug", unique: true
  end

  create_table "passengers", force: :cascade do |t|
    t.string "name"
    t.string "id_proof"
    t.integer "age"
    t.string "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seat_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_seat_categories_on_slug", unique: true
  end

  create_table "ticket_bookings", force: :cascade do |t|
    t.bigint "flight_assignment_id"
    t.bigint "flight_seat_id"
    t.bigint "user_id"
    t.float "payble_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "passenger_id"
    t.index ["flight_assignment_id"], name: "index_ticket_bookings_on_flight_assignment_id"
    t.index ["flight_seat_id"], name: "index_ticket_bookings_on_flight_seat_id"
    t.index ["user_id"], name: "index_ticket_bookings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.string "age"
    t.string "contact_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "flight_assignments", "flights"
  add_foreign_key "flight_configurations", "seat_categories"
  add_foreign_key "flight_seat_configurations", "flight_configurations"
  add_foreign_key "flight_seat_configurations", "flights"
  add_foreign_key "flight_seats", "flight_seat_configurations"
  add_foreign_key "flight_seats", "flights"
  add_foreign_key "ticket_bookings", "flight_assignments"
  add_foreign_key "ticket_bookings", "flight_seats"
  add_foreign_key "ticket_bookings", "users"
end
