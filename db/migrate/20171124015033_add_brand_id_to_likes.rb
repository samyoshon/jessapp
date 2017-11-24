class AddBrandIdToLikes < ActiveRecord::Migration[5.1]
  def change
  	add_reference :likes, :brand, index: true
    add_foreign_key :likes, :brands
    add_reference :likes, :forum_thread, index: true
    add_foreign_key :likes, :forum_threads
    add_reference :likes, :forum_post, index: true
    add_foreign_key :likes, :forum_posts
  end
end
