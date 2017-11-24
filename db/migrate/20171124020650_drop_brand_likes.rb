class DropBrandLikes < ActiveRecord::Migration[5.1]
  def change
  	drop_table :brand_likes
  	drop_table :forum_post_likes
  	drop_table :forum_thread_likes
  	drop_table :brand_flags
  	drop_table :product_favorites
  	add_reference :flags, :brand, index: true
    add_foreign_key :flags, :brands
    add_reference :favorites, :product, index: true
    add_foreign_key :favorites, :products
    add_reference :reviews, :brand, index: true
    add_foreign_key :reviews, :brands
  end
end
