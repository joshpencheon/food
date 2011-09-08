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

ActiveRecord::Schema.define(:version => 20110908180146) do

  create_table "baskets", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "shop_date"
    t.integer  "shop_id"
  end

  create_table "bills", :force => true do |t|
    t.integer  "basket_id"
    t.integer  "proportion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "ean"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchases", :force => true do |t|
    t.integer  "product_id"
    t.integer  "unit_price_in_pence"
    t.integer  "quantity"
    t.integer  "saving_in_pence",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "basket_id"
  end

  create_table "shops", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
