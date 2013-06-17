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

ActiveRecord::Schema.define(:version => 20130617021140) do

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

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.string   "city"
    t.string   "country"
    t.string   "email"
    t.string   "phone"
    t.string   "postcode"
    t.string   "website"
    t.string   "facebook_id"
    t.string   "linkedin_id"
    t.string   "twitter_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "logo_url"
  end

  create_table "company_competence_rs", :force => true do |t|
    t.integer  "competence_id"
    t.integer  "company_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "company_industry_rs", :force => true do |t|
    t.integer  "industry_id"
    t.integer  "company_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "company_matrix_rs", :force => true do |t|
    t.integer  "company_id"
    t.integer  "matrix_id"
    t.boolean  "is_approved"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "competences", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "is_approve"
  end

  create_table "facebook_feeds", :force => true do |t|
    t.integer  "company_id"
    t.integer  "matrix_id"
    t.string   "title"
    t.text     "content"
    t.string   "url"
    t.boolean  "is_top"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "feed_matrix_rs", :force => true do |t|
    t.integer  "feed_id"
    t.integer  "matrix_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "feeds", :force => true do |t|
    t.string   "title"
    t.string   "photo_url"
    t.integer  "company_id"
    t.string   "url"
    t.integer  "shares"
    t.integer  "likes"
    t.datetime "origin_created_time"
    t.text     "content"
    t.string   "feed_type"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "follower_matrix_rs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "matrix_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "industries", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "is_approve"
  end

  create_table "linkedin_auths", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "full_name"
    t.string   "headline"
    t.string   "industry"
    t.string   "last_name"
    t.string   "location"
    t.string   "phone"
    t.string   "photo"
    t.string   "raw_auth"
    t.string   "secret"
    t.string   "token"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "linkedin_feeds", :force => true do |t|
    t.integer  "company_id"
    t.integer  "matrix_id"
    t.string   "title"
    t.text     "content"
    t.string   "url"
    t.boolean  "is_top"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "linkedin_updates", :force => true do |t|
    t.integer  "linkedin_company_id"
    t.string   "update_key"
    t.string   "update_type"
    t.text     "raw_data"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "linkedin_updates", ["update_key"], :name => "index_linkedin_updates_on_update_key", :unique => true

  create_table "manual_feeds", :force => true do |t|
    t.integer  "company_id"
    t.integer  "matrix_id"
    t.string   "title"
    t.text     "content"
    t.string   "url"
    t.boolean  "is_top"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "matrices", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "matrix_follower_rs", :force => true do |t|
    t.integer  "matrix_id"
    t.integer  "follower_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "matrix_keywords", :force => true do |t|
    t.integer  "matrix_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "media_feeds", :force => true do |t|
    t.integer  "company_id"
    t.integer  "matrix_id"
    t.string   "title"
    t.text     "content"
    t.string   "url"
    t.boolean  "is_top"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "twitter_feeds", :force => true do |t|
    t.integer  "company_id"
    t.integer  "matrix_id"
    t.string   "title"
    t.text     "content"
    t.string   "url"
    t.boolean  "is_top"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_company_rs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_matrix_rs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "matrix_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
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
    t.integer  "linkedin_auth_id"
    t.string   "linkedin_uid"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["linkedin_uid"], :name => "index_users_on_linkedin_uid", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
