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

ActiveRecord::Schema.define(:version => 20130408135606) do

  create_table "generic_fleets", :force => true do |t|
    t.integer  "squad_id"
    t.integer  "planet_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "generic_unit_id"
    t.boolean  "moving"
    t.integer  "destination_id"
    t.string   "type"
    t.integer  "balance"
    t.integer  "producing_unit_id"
    t.string   "fleet_name"
    t.boolean  "sabotaged"
    t.integer  "level"
    t.integer  "producing_unit2_id"
  end

  create_table "generic_units", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.integer  "faction_mask"
    t.boolean  "hyperdrive"
  end

  create_table "generic_units_squads", :id => false, :force => true do |t|
    t.integer "generic_unit_id"
    t.integer "squad_id"
  end

  create_table "goals", :force => true do |t|
    t.text    "description"
    t.boolean "used"
  end

  create_table "planets", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "squad_id"
    t.integer  "credits"
    t.integer  "ground_squad_id"
    t.boolean  "wormhole"
    t.boolean  "tradeport"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_histories_on_item_and_table_and_month_and_year"

  create_table "results", :force => true do |t|
    t.integer  "generic_unit_id"
    t.integer  "quantity"
    t.integer  "planet_id"
    t.integer  "generic_fleet_id"
    t.integer  "blasted"
    t.integer  "captured"
    t.integer  "fled"
    t.integer  "squad_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "round_id"
    t.integer  "captor_id"
    t.boolean  "sabotaged"
  end

  create_table "rounds", :force => true do |t|
    t.integer  "number"
    t.boolean  "move"
    t.boolean  "attack"
    t.boolean  "done"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "routes", :force => true do |t|
    t.integer  "vector_a"
    t.integer  "vector_b"
    t.integer  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "squads", :force => true do |t|
    t.string   "name"
    t.integer  "credits"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "ready"
    t.string   "color"
    t.integer  "faction"
    t.integer  "goal_id"
  end

  create_table "tradeports", :force => true do |t|
    t.integer  "generic_unit_id"
    t.integer  "quantity"
    t.integer  "negotiation_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "squad_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
