class CreateUsers < ActiveRecord::Migration[5.1]
def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :phone_number
      t.text :images
      t.boolean :admin, default: false
      t.boolean :is_advertiser
      t.boolean :is_mod
      t.boolean :is_flagged
      t.string :facebook
      t.string :instagram
      t.string :twitter
      t.string :snapchat
      # t.integer :school_class
      # t.string :school_program

      t.timestamps null: false
    end

    create_table :markets do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :store_id
      t.string :title
      t.text :description
      t.text :subdomain
      t.text :images
      t.string :first_color
      t.string :second_color
      t.string :email_address_type
      
      
      t.timestamps null: false
    end

    create_table :forum_threads do |t|
      t.references :user, index: true, foreign_key: true
      t.string :subject
      t.integer :view_count
      t.integer :post_count
      t.text :images
      t.references :market, index: true, foreign_key: true
      

      t.timestamps null: false
    end

    create_table :forum_posts do |t|
      t.references :forum_thread, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.text :body
      t.text :images

      t.timestamps null: false
    end

    create_table :groups do |t|
      t.string :name
      t.references :market, foreign_key: true
    end

    create_table :categories do |t|
      t.string :category_name
      t.references :user, index: true, foreign_key: true
      t.references :market, index: true, foreign_key: true
      t.references :group, index: true, foreign_key: true

      t.timestamps null: false
    end

    create_table :products do |t|
      t.references :user, index: true, foreign_key: true
      t.references :market, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.string :images, array: true, default: [] # add images column as array
      t.integer :price
      t.datetime :expire_date
      t.integer :view_count
      t.integer :contact_count
      t.string :contact_pref
      t.boolean :contact_by_email, default: true
      t.boolean :contact_by_phone, default: false

      t.timestamps null: false
    end

    create_table :forum_categories do |t|
      t.string :category_name
      t.references :user, index: true, foreign_key: true
      t.references :market, index: true, foreign_key: true
      t.references :group, index: true, foreign_key: true

      t.timestamps null: false
    end

    create_table :banners do |t|
      t.references :user, index: true, foreign_key: true
      t.references :market, index: true, foreign_key: true
      t.text :product_index
      t.text :product_show
      t.text :product_new
      t.text :forum_index
      t.text :forum_show
      t.text :forum_new
      t.text :account_profile

      t.timestamps null: false
    end

    create_table :flags do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.timestamps
    end

    add_column :users, :deleted_at, :timestamp
    add_index :users, :deleted_at

    add_column :forum_threads, :deleted_at, :datetime
    add_index :forum_threads, :deleted_at

    add_reference :users, :market, index: true, foreign_key: true
    add_reference :markets, :group, index: true, foreign_key: true
    add_reference :forum_threads, :forum_category, index: true, foreign_key: true



    
end
end
