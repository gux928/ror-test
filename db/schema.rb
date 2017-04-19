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

ActiveRecord::Schema.define(version: 20161112033909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fixed_assets", force: :cascade do |t|
    t.string   "number"
    t.string   "belongs_to"
    t.string   "main_class"
    t.string   "sub_class"
    t.string   "serial_number"
    t.string   "month_of_purchase"
    t.string   "position"
    t.string   "brand"
    t.string   "model"
    t.string   "remarks"
    t.string   "user"
    t.string   "unit_price"
    t.string   "invoice"
    t.string   "photo"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "rec_docs", force: :cascade do |t|
    t.text     "wjnr"
    t.date     "riqi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "from"
    t.string   "from_code"
    t.integer  "year"
    t.integer  "year_num"
    t.integer  "doc_type"
    t.string   "tiff"
    t.integer  "png_num"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "name"
    t.string   "phone"
    t.string   "phone_short"
    t.string   "id_num"
    t.string   "office"
    t.boolean  "party_member"
    t.integer  "authority"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["id_num"], name: "index_users_on_id_num", unique: true, using: :btree
    t.index ["phone"], name: "index_users_on_phone", unique: true, using: :btree
    t.index ["phone_short"], name: "index_users_on_phone_short", unique: true, using: :btree
  end

end
