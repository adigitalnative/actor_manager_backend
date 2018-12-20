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

ActiveRecord::Schema.define(version: 2018_12_20_212311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audition_pieces", force: :cascade do |t|
    t.bigint "book_item_id"
    t.bigint "audition_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["audition_id"], name: "index_audition_pieces_on_audition_id"
    t.index ["book_item_id"], name: "index_audition_pieces_on_book_item_id"
  end

  create_table "auditions", force: :cascade do |t|
    t.text "bring"
    t.text "prepare"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id"
    t.bigint "category_id"
    t.bigint "user_id"
    t.datetime "date_and_time"
    t.index ["category_id"], name: "index_auditions_on_category_id"
    t.index ["project_id"], name: "index_auditions_on_project_id"
    t.index ["user_id"], name: "index_auditions_on_user_id"
  end

  create_table "book_items", force: :cascade do |t|
    t.string "title"
    t.string "role"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "author"
    t.index ["user_id"], name: "index_book_items_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "result_id"
    t.index ["company_id"], name: "index_projects_on_company_id"
    t.index ["result_id"], name: "index_projects_on_result_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "audition_id"
    t.text "notes"
    t.text "people"
    t.text "auditors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["audition_id"], name: "index_reports_on_audition_id"
  end

  create_table "results", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "booked", default: false, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "audition_pieces", "auditions"
  add_foreign_key "audition_pieces", "book_items"
  add_foreign_key "auditions", "categories"
  add_foreign_key "auditions", "projects"
  add_foreign_key "auditions", "users"
  add_foreign_key "book_items", "users"
  add_foreign_key "companies", "users"
  add_foreign_key "projects", "companies"
  add_foreign_key "projects", "results"
  add_foreign_key "projects", "users"
  add_foreign_key "reports", "auditions"
end
