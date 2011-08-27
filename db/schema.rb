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

ActiveRecord::Schema.define(:version => 20110826195811) do

  create_table "steps", :force => true do |t|
    t.integer  "trip_id"
    t.datetime "arrival"
    t.datetime "departure"
    t.text     "description"
    t.string   "location"
    t.float    "lat"
    t.float    "lng"
    t.text     "travel_info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trips", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.text     "description"
    t.string   "marketable_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
