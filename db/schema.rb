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

ActiveRecord::Schema.define(version: 20170830141011) do

  create_table "novels", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ncode"
    t.string "title"
    t.text "story"
    t.integer "genre"
    t.integer "big_genre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "ends"
    t.integer "novel_type"
  end

  create_table "unnovels", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.integer "novel_id"
    t.string "duration"
    t.float "points", limit: 24
  end

  create_table "updates", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ncode"
    t.integer "length"
    t.integer "all_point"
    t.integer "all_hyoka_cnt"
    t.integer "global_point"
    t.integer "fav_novel_cnt"
    t.integer "review_cnt"
    t.datetime "novel_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "general_all_no"
    t.index ["ncode", "novel_updated_at"], name: "index_updates_on_ncode_and_novel_updated_at", unique: true
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "writer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "userid"
    t.index ["userid"], name: "index_users_on_userid"
  end

end
