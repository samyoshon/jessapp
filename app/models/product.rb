class Product < ApplicationRecord
	mount_uploaders :images, ImageUploader
	# include ImageUploader::Attachment.new(:image)
	

	belongs_to :user
	belongs_to :market
	belongs_to :category
	belongs_to :brand

	has_many :flags
	has_many :likes
	has_many :reviews
	has_many :favorites

	def user
    	User.unscoped { super }
   	end

   	def to_param
    	"#{id}-#{title}".parameterize
  	end
end
