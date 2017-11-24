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

ActiveRecord::Schema.define(version: 20171124020650) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "banners", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "market_id"
    t.text "product_index"
    t.text "product_show"
    t.text "product_new"
    t.text "forum_index"
    t.text "forum_show"
    t.text "forum_new"
    t.text "account_profile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["market_id"], name: "index_banners_on_market_id"
    t.index ["user_id"], name: "index_banners_on_user_id"
  end

  create_table "brand_categories", force: :cascade do |t|
    t.string "category_name"
    t.bigint "user_id"
    t.bigint "brand_id"
    t.bigint "market_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_brand_categories_on_brand_id"
    t.index ["group_id"], name: "index_brand_categories_on_group_id"
    t.index ["market_id"], name: "index_brand_categories_on_market_id"
    t.index ["user_id"], name: "index_brand_categories_on_user_id"
  end

  create_table "brands", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "product_id"
    t.bigint "review_id"
    t.string "name"
    t.string "username"
    t.text "about"
    t.string "images", default: [], array: true
    t.string "phone_number"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "website"
    t.string "youtube"
    t.string "facebook"
    t.string "instagram"
    t.string "twitter"
    t.string "snapchat"
    t.text "payment_policy"
    t.text "return_policy"
    t.text "shipping_policy"
    t.text "faq_policy"
    t.text "other_policy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "brand_category_id"
    t.string "email"
    t.text "logo"
    t.index ["brand_category_id"], name: "index_brands_on_brand_category_id"
    t.index ["product_id"], name: "index_brands_on_product_id"
    t.index ["review_id"], name: "index_brands_on_review_id"
    t.index ["user_id"], name: "index_brands_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.bigint "user_id"
    t.bigint "market_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon"
    t.index ["group_id"], name: "index_categories_on_group_id"
    t.index ["market_id"], name: "index_categories_on_market_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.index ["brand_id"], name: "index_favorites_on_brand_id"
    t.index ["product_id"], name: "index_favorites_on_product_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "flags", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "brand_id"
    t.index ["brand_id"], name: "index_flags_on_brand_id"
    t.index ["product_id"], name: "index_flags_on_product_id"
    t.index ["user_id"], name: "index_flags_on_user_id"
  end

  create_table "forum_categories", force: :cascade do |t|
    t.string "category_name"
    t.bigint "user_id"
    t.bigint "market_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon"
    t.index ["group_id"], name: "index_forum_categories_on_group_id"
    t.index ["market_id"], name: "index_forum_categories_on_market_id"
    t.index ["user_id"], name: "index_forum_categories_on_user_id"
  end

  create_table "forum_posts", force: :cascade do |t|
    t.bigint "forum_thread_id"
    t.bigint "user_id"
    t.text "body"
    t.text "images"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["forum_thread_id"], name: "index_forum_posts_on_forum_thread_id"
    t.index ["user_id"], name: "index_forum_posts_on_user_id"
  end

  create_table "forum_threads", force: :cascade do |t|
    t.bigint "user_id"
    t.string "subject"
    t.integer "view_count"
    t.integer "post_count"
    t.text "images"
    t.bigint "market_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.bigint "forum_category_id"
    t.index ["deleted_at"], name: "index_forum_threads_on_deleted_at"
    t.index ["forum_category_id"], name: "index_forum_threads_on_forum_category_id"
    t.index ["market_id"], name: "index_forum_threads_on_market_id"
    t.index ["user_id"], name: "index_forum_threads_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.bigint "market_id"
    t.index ["market_id"], name: "index_groups_on_market_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "brand_id"
    t.bigint "forum_thread_id"
    t.bigint "forum_post_id"
    t.index ["brand_id"], name: "index_likes_on_brand_id"
    t.index ["forum_post_id"], name: "index_likes_on_forum_post_id"
    t.index ["forum_thread_id"], name: "index_likes_on_forum_thread_id"
    t.index ["product_id"], name: "index_likes_on_product_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "markets", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "store_id"
    t.string "title"
    t.text "description"
    t.text "subdomain"
    t.text "images"
    t.string "first_color"
    t.string "second_color"
    t.string "email_address_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_id"
    t.index ["group_id"], name: "index_markets_on_group_id"
    t.index ["user_id"], name: "index_markets_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "market_id"
    t.bigint "category_id"
    t.string "title"
    t.text "description"
    t.string "images", default: [], array: true
    t.integer "price"
    t.datetime "expire_date"
    t.integer "view_count"
    t.integer "contact_count"
    t.string "contact_pref"
    t.boolean "contact_by_email", default: true
    t.boolean "contact_by_phone", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "review_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["market_id"], name: "index_products_on_market_id"
    t.index ["review_id"], name: "index_products_on_review_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "product_id"
    t.string "review"
    t.string "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "brand_id"
    t.index ["brand_id"], name: "index_reviews_on_brand_id"
    t.index ["product_id"], name: "index_reviews_on_product_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "phone_number"
    t.text "images"
    t.boolean "admin", default: false
    t.boolean "is_advertiser"
    t.boolean "is_mod"
    t.boolean "is_flagged"
    t.string "facebook"
    t.string "instagram"
    t.string "twitter"
    t.string "snapchat"
    t.integer "school_class"
    t.string "school_program"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.bigint "market_id"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["market_id"], name: "index_users_on_market_id"
  end

  add_foreign_key "banners", "markets"
  add_foreign_key "banners", "users"
  add_foreign_key "brand_categories", "brands"
  add_foreign_key "brand_categories", "groups"
  add_foreign_key "brand_categories", "markets"
  add_foreign_key "brand_categories", "users"
  add_foreign_key "brands", "brand_categories"
  add_foreign_key "brands", "products"
  add_foreign_key "brands", "reviews"
  add_foreign_key "brands", "users"
  add_foreign_key "categories", "groups"
  add_foreign_key "categories", "markets"
  add_foreign_key "categories", "users"
  add_foreign_key "favorites", "brands"
  add_foreign_key "favorites", "products"
  add_foreign_key "favorites", "users"
  add_foreign_key "flags", "brands"
  add_foreign_key "flags", "products"
  add_foreign_key "flags", "users"
  add_foreign_key "forum_categories", "groups"
  add_foreign_key "forum_categories", "markets"
  add_foreign_key "forum_categories", "users"
  add_foreign_key "forum_posts", "forum_threads"
  add_foreign_key "forum_posts", "users"
  add_foreign_key "forum_threads", "forum_categories"
  add_foreign_key "forum_threads", "markets"
  add_foreign_key "forum_threads", "users"
  add_foreign_key "groups", "markets"
  add_foreign_key "likes", "brands"
  add_foreign_key "likes", "forum_posts"
  add_foreign_key "likes", "forum_threads"
  add_foreign_key "likes", "products"
  add_foreign_key "likes", "users"
  add_foreign_key "markets", "groups"
  add_foreign_key "markets", "users"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "markets"
  add_foreign_key "products", "reviews"
  add_foreign_key "products", "users"
  add_foreign_key "reviews", "brands"
  add_foreign_key "reviews", "products"
  add_foreign_key "reviews", "users"
  add_foreign_key "users", "markets"
end
