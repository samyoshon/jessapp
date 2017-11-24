class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.string :review
      t.string :rating
      t.timestamps
    end

    create_table :forum_thread_likes do |t|
      t.references :user, foreign_key: true
      t.references :forum_thread, foreign_key: true
      t.timestamps
    end

    create_table :forum_post_likes do |t|
      t.references :user, foreign_key: true
      t.references :forum_post, foreign_key: true
      t.timestamps
    end

    create_table :brands do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.references :review, foreign_key: true
      t.string :name
      t.string :username
      t.text :about
	  t.string :images, array: true, default: [] # add images column as array
      t.string :phone_number
      t.string :city
      t.string :state
      t.string :country
      t.string :website
      t.string :youtube
      t.string :facebook
      t.string :instagram
      t.string :twitter
      t.string :snapchat
      t.text :payment_policy
      t.text :return_policy
      t.text :shipping_policy
      t.text :faq_policy
      t.text :other_policy
      t.timestamps
    end

    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :brand, foreign_key: true
      t.timestamps
    end

    create_table :product_favorites do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.timestamps
    end

    create_table :brand_flags do |t|
      t.references :user, foreign_key: true
      t.references :brand, foreign_key: true
      t.timestamps
    end

    create_table :brand_categories do |t|
      t.string :category_name
      t.references :user, index: true, foreign_key: true
      t.references :brand, index: true, foreign_key: true
      t.references :market, index: true, foreign_key: true
      t.references :group, index: true, foreign_key: true
      t.timestamps null: false
    end

	add_reference :brands, :brand_category, index: true
	add_foreign_key :brands, :brand_categories
  end
end
