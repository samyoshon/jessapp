class ForumCategory < ApplicationRecord
  has_many :forum_threads
end
