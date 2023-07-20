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

ActiveRecord::Schema.define(version: 2023_07_20_070152) do

  create_table "deleted_domains", force: :cascade do |t|
    t.string "fqdn"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ips", force: :cascade do |t|
    t.integer "search_result_id", null: false
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["search_result_id"], name: "index_ips_on_search_result_id"
  end

  create_table "phrases", force: :cascade do |t|
    t.string "name"
    t.string "hl"
    t.string "gl"
    t.string "google_domain"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "search_results", force: :cascade do |t|
    t.integer "phrase_id", null: false
    t.integer "position"
    t.string "source"
    t.text "title"
    t.text "link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["phrase_id"], name: "index_search_results_on_phrase_id"
  end

  add_foreign_key "ips", "search_results"
  add_foreign_key "search_results", "phrases"
end
