# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170213212619) do

  create_table "apps", force: :cascade do |t|
    t.integer "org_id"
    t.integer "status",         default: 0
    t.string  "name"
    t.string  "description"
    t.string  "deployment_url"
    t.string  "repository_url"
  end

  add_index "apps", ["org_id"], name: "index_apps_on_org_id"

  create_table "engagements", force: :cascade do |t|
    t.integer  "app_id"
    t.string   "team_number"
    t.datetime "start_date"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "screencast_url"
    t.string   "screenshot_url"
    t.string   "poster_url"
    t.string   "presentation_url"
    t.string   "prototype_deployment_url"
    t.string   "student_names"
  end

  add_index "engagements", ["app_id"], name: "index_engagements_on_app_id"

  create_table "orgs", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "url"
    t.string "contact_name"
    t.string "contact_email"
  end

end
