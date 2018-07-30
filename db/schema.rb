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

ActiveRecord::Schema.define(version: 20161011163001) do

  create_table "cost_dependencies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "dependency_category"
    t.string  "dependency_option"
    t.decimal "per_page",            precision: 5, scale: 2, default: "0.0"
    t.decimal "per_job",             precision: 5, scale: 2, default: "0.0"
    t.integer "cost_id"
  end

  create_table "costs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "category"
    t.decimal "per_job",  precision: 5, scale: 2, default: "0.0"
    t.decimal "per_page", precision: 5, scale: 2, default: "0.0"
    t.string  "option"
  end

  create_table "request_attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "request_id"
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "jobtitle"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.string   "requester"
    t.string   "status"
    t.text     "pickup_date",       limit: 65535
    t.string   "costcenter"
    t.string   "costcenter_number"
    t.string   "originals"
    t.string   "sides"
    t.string   "stock"
    t.string   "binding"
    t.string   "folding"
    t.string   "color_copy"
    t.integer  "collate"
    t.integer  "staple"
    t.integer  "threehole"
    t.integer  "cut"
    t.integer  "laminate"
    t.integer  "pad"
    t.string   "color"
    t.text     "special_info",      limit: 65535
    t.decimal  "cost",                            precision: 10
    t.string   "completion"
    t.integer  "copies"
    t.string   "size"
    t.string   "weight"
    t.string   "finish"
    t.decimal  "estimate",                        precision: 10, default: 0
    t.integer  "clear_cover"
    t.decimal  "otherestimate",                   precision: 10, default: 0
    t.boolean  "billed",                                         default: false
    t.integer  "black_back"
  end

end
