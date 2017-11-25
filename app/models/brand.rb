class Brand < ApplicationRecord
	extend FriendlyId
  	friendly_id :name, use: [:slugged, :finders]

	mount_uploader :logo, ImageUploader
	belongs_to :user
	belongs_to :market
	belongs_to :brand_category

	has_many :flags
	has_many :products
	has_many :likes
	has_many :favorites

	validates_uniqueness_of :name
end
