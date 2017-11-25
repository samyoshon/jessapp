class CreateFriendlyIdSlugs < ActiveRecord::Migration[5.1]
  def change
    create_table :friendly_id_slugs do |t|
      t.string   :slug,           :null => false
      t.integer  :sluggable_id,   :null => false
      t.string   :sluggable_type, :limit => 50
      t.string   :scope
      t.datetime :created_at
    end
    add_index :friendly_id_slugs, :sluggable_id
    add_index :friendly_id_slugs, [:slug, :sluggable_type]
    add_index :friendly_id_slugs, [:slug, :sluggable_type, :scope], :unique => true
    add_index :friendly_id_slugs, :sluggable_type

    add_column :users, :slug, :string, unique: true
    add_column :brands, :slug, :string, unique: true
    add_column :brands, :tagline, :string
    add_column :brands, :is_wholesale, :boolean, default: false
    add_column :products, :slug, :string, unique: true
    add_column :forum_threads, :slug, :string, unique: true

    add_index :users, :slug, unique: true
    add_index :brands, :slug, unique: true
    add_index :products, :slug, unique: true
    add_index :forum_threads, :slug, unique: true
  end
end
