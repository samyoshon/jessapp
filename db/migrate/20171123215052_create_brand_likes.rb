class CreateBrandLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :brand_likes do |t|
      t.references :user, foreign_key: true
      t.references :brand, foreign_key: true
      t.timestamps
    end
  end
end
