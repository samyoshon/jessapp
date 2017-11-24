class ForumThread < ApplicationRecord
  # acts_as_paranoid
  belongs_to :user
  belongs_to :market
  belongs_to :forum_category

  has_many :forum_posts
  has_many :users, through: :forum_posts

  accepts_nested_attributes_for :forum_posts

  validates :subject, presence: true
  validates_associated :forum_posts
  
  def user
    User.unscoped { super }
  end

  def to_param
    "#{id}-#{subject}".parameterize
  end
end
