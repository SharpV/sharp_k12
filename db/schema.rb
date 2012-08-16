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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120816155936) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "categories", :force => true do |t|
    t.integer "parent_id"
    t.string  "name"
    t.integer "lft"
    t.integer "rgt"
    t.integer "user_id"
    t.integer "group_id"
  end

  add_index "categories", ["group_id"], :name => "index_categories_on_group_id"
  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"

  create_table "cities", :force => true do |t|
    t.integer "province_code"
    t.integer "code",          :null => false
    t.string  "name"
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "documents", :force => true do |t|
    t.integer "likes_count",        :default => 0
    t.string  "name"
    t.string  "file"
    t.text    "summary"
    t.integer "downloadings_count", :default => 0
    t.integer "category_id"
    t.integer "group_id"
    t.integer "user_id"
    t.integer "readings_count",     :default => 0
  end

  add_index "documents", ["category_id"], :name => "index_documents_on_category_id"
  add_index "documents", ["group_id"], :name => "index_documents_on_group_id"
  add_index "documents", ["user_id"], :name => "index_documents_on_user_id"

  create_table "grades", :force => true do |t|
    t.integer "parent_id"
    t.string  "name"
    t.integer "lft"
    t.integer "rgt"
  end

  add_index "grades", ["parent_id"], :name => "index_grades_on_parent_id"

  create_table "group_members", :force => true do |t|
    t.boolean  "admin",      :default => false
    t.boolean  "active",     :default => false
    t.integer  "user_id",                       :null => false
    t.integer  "group_id",                      :null => false
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_members", ["active"], :name => "index_group_members_on_active"
  add_index "group_members", ["group_id"], :name => "index_group_members_on_group_id"
  add_index "group_members", ["user_id", "group_id"], :name => "index_group_members_on_user_id_and_group_id"
  add_index "group_members", ["user_id"], :name => "index_group_members_on_user_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "permalink",                              :null => false
    t.boolean  "public",              :default => false
    t.integer  "user_id",                                :null => false
    t.integer  "grade_id"
    t.integer  "subject_id"
    t.integer  "group_members_count", :default => 0
    t.text     "description"
    t.string   "logo"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "settings"
    t.boolean  "deleted",             :default => false, :null => false
  end

  add_index "groups", ["grade_id"], :name => "index_groups_on_grade_id"
  add_index "groups", ["kind"], :name => "index_groups_on_kind"
  add_index "groups", ["permalink"], :name => "index_groups_on_permalink"
  add_index "groups", ["user_id"], :name => "index_groups_on_user_id"

  create_table "notes", :force => true do |t|
    t.text     "body"
    t.boolean  "active",            :default => true
    t.integer  "plan_id"
    t.integer  "group_id"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "edited_at"
    t.integer  "views_count",       :default => 0
    t.integer  "comments_count",    :default => 0
    t.integer  "likes_count",       :default => 0
    t.integer  "collections_count", :default => 0
    t.integer  "user_id"
    t.integer  "category_id"
  end

  add_index "notes", ["group_id"], :name => "index_notes_on_group_id"
  add_index "notes", ["plan_id"], :name => "index_notes_on_plan_id"
  add_index "notes", ["user_id"], :name => "index_notes_on_user_id"

  create_table "pages", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "group_id",    :null => false
    t.string   "title"
    t.text     "body"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["category_id"], :name => "index_pages_on_category_id"
  add_index "pages", ["group_id"], :name => "index_pages_on_group_id"
  add_index "pages", ["user_id"], :name => "index_pages_on_user_id"

  create_table "post_assets", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.string   "file"
  end

  add_index "post_assets", ["post_id"], :name => "index_post_assets_on_post_id"
  add_index "post_assets", ["user_id"], :name => "index_post_assets_on_user_id"

  create_table "posts", :force => true do |t|
    t.string   "title",                            :null => false
    t.text     "body",                             :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",    :default => 0
    t.integer  "likes_count",       :default => 0
    t.integer  "collections_count", :default => 0
    t.datetime "done_at"
    t.string   "kind"
    t.string   "link"
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "category_id"
    t.integer  "done",              :default => 0
  end

  add_index "posts", ["category_id"], :name => "index_posts_on_category_id"
  add_index "posts", ["group_id"], :name => "index_posts_on_group_id"
  add_index "posts", ["kind"], :name => "index_posts_on_kind"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "organization", :limit => 45
    t.string   "phone",        :limit => 45
    t.string   "mobile",       :limit => 45
    t.string   "fax",          :limit => 45
    t.string   "address"
    t.string   "city"
    t.string   "zipcode",      :limit => 45
    t.string   "province",     :limit => 45
    t.string   "country",      :limit => 45
    t.integer  "prefix_key"
    t.string   "description"
    t.string   "experience"
    t.string   "website"
    t.string   "skype",        :limit => 45
    t.string   "im",           :limit => 45
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "provinces", :force => true do |t|
    t.string  "name"
    t.string  "mark"
    t.integer "code", :null => false
  end

  create_table "subjects", :force => true do |t|
    t.integer "parent_id"
    t.string  "name"
    t.integer "lft"
    t.integer "rgt"
    t.integer "grade_id"
  end

  add_index "subjects", ["grade_id"], :name => "index_subjects_on_grade_id"
  add_index "subjects", ["parent_id"], :name => "index_subjects_on_parent_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "login"
    t.integer  "views_count",            :default => 0,  :null => false
    t.integer  "reputation",             :default => 0
    t.integer  "field_id"
    t.string   "avatar"
    t.integer  "city_code"
    t.integer  "zone_code"
    t.integer  "province_code"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["city_code"], :name => "index_users_on_city_code"
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["field_id"], :name => "index_users_on_field_id"
  add_index "users", ["province_code"], :name => "index_users_on_province_code"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "zones", :force => true do |t|
    t.integer  "code",       :null => false
    t.string   "name",       :null => false
    t.integer  "city_code",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "zones", ["city_code"], :name => "index_zones_on_city_code"

end
