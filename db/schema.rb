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

ActiveRecord::Schema.define(:version => 20120507022722) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "monsters", :force => true do |t|
    t.string   "name"
    t.integer  "level"
    t.decimal  "experience"
    t.integer  "user_id"
    t.integer  "species_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.decimal  "max_hp"
    t.decimal  "max_attack"
    t.decimal  "max_defense"
    t.decimal  "current_hp"
    t.decimal  "current_attack"
    t.decimal  "current_defense"
  end

  create_table "moves", :force => true do |t|
    t.string   "name"
    t.decimal  "power"
    t.decimal  "hit_chance"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "animation"
  end

  create_table "species", :force => true do |t|
    t.string   "name"
    t.decimal  "hp_growth"
    t.decimal  "attack_growth"
    t.decimal  "defense_growth"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "image_url"
  end

  create_table "species_moves", :force => true do |t|
    t.integer  "species_id"
    t.integer  "move_id"
    t.integer  "level_learned"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
