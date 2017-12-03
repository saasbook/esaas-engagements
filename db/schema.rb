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

ActiveRecord::Schema.define(version: 20171202224507) do

  create_table "apps", force: :cascade do |t|
    t.integer  "org_id"
    t.integer  "status",           default: 5
    t.string   "name"
    t.string   "description"
    t.string   "deployment_url"
    t.string   "repository_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code_climate_url"
  end

  add_index "apps", ["org_id"], name: "index_apps_on_org_id"

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "commentable_id"
    t.integer  "user_id"
    t.integer  "comment_type"
    t.string   "commentable_type"
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"

  create_table "engagements", force: :cascade do |t|
    t.integer  "app_id"
    t.string   "team_number"
    t.datetime "start_date"
    t.integer  "coach_id"
    t.string   "screencast_url"
    t.string   "screenshot_url"
    t.string   "poster_url"
    t.string   "presentation_url"
    t.string   "prototype_deployment_url"
    t.string   "student_names"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "repository_url"
  end

  add_index "engagements", ["app_id"], name: "index_engagements_on_app_id"
  add_index "engagements", ["coach_id"], name: "index_engagements_on_coach_id"

  create_table "iterations", force: :cascade do |t|
    t.integer  "engagement_id"
    t.text     "customer_feedback"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orgs", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "url"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city_state_zip"
    t.string   "phone"
    t.boolean  "defunct",        default: false
  end

  add_index "orgs", ["contact_id"], name: "index_orgs_on_contact_id"

  create_table "pending_feedbacks", force: :cascade do |t|
    t.integer  "engagement_id"
    t.integer  "iteration_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "github_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "preferred_contact"
    t.string   "sid"
    t.string   "type_user"
    t.integer  "developing_engagement_id"
    t.integer  "coaching_org_id"
    t.integer  "user_type"
  end

  add_index "users", ["developing_engagement_id"], name: "index_users_on_developing_engagement_id"

end
