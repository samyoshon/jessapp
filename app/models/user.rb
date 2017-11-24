class User < ApplicationRecord
  mount_uploader :images, ImageUploader
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable #, :confirmable
  # accepts_nested_attributes_for :markets
  
  # validates :email, email_format: true
  validate :email
  validates_uniqueness_of :username
  validates_format_of :username, :with => /\A[a-zA-Z0-9]*\z/, :message => "letters and numbers only"
  validates_format_of :facebook, :instagram, :twitter, :with => /\A[a-zA-Z0-9._]*\z/, :message => "letters, numbers, periods, and underscores only"
  validates_format_of :first_name, :last_name, :with => /\A[a-zA-Z]*\z/, :message => "invalid entry, only letters allowed"

  belongs_to :market
  has_many :forum_threads
  has_many :forum_posts
  
  has_one :brand
  has_many :products
  has_many :likes
  has_many :favorites
  has_many :flags


  def likes?(brand)
    brand.likes.where(user_id: id).any?
  end

  def favorites?(brand)
    brand.favorites.where(user_id: id).any?
  end

  def self.assign_from_row(row)
    user = User.where(email: row[:email]).first_or_initialize
    user.assign_attributes row.to_hash.slice(:first_name, :last_name, :market_id, :phone_number, :images, :admin, :is_advertiser, :is_mod, :username, :school_class, :school_program, :facebook, :instagram, :twitter, :snapchat)
  end

  def self.to_csv
    attributes = %w{id email name}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

  def name
    if deleted_at?
      "Deleted User"
    else
      "#{first_name} #{last_name}"
    end
  end

end