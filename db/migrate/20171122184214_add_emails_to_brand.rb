class AddEmailsToBrand < ActiveRecord::Migration[5.1]
  def change
  	add_column :brands, :email, :string
  	add_column :brands, :logo, :text
  end
end
