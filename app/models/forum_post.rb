class ForumPost < ApplicationRecord
  # include ImageUploader::Attachment.new(:image)

  mount_uploader :images, ImageUploader
  belongs_to :user
  belongs_to :forum_thread

  validates :body, presence: true

  # after_create :notified_users

  # def notified_users
  #     mentioned_users.each do |user|
  #         Mail.new(user)
  #     end
  # end


  def mentions
    @mentions ||= begin
        regex = /@([\w]+)/
        body.scan(regex).flatten
    end 
  end

  def mentioned_users
      @mentioned_users ||= User.where(username: mentions)
  end 

  def user
    User.unscoped { super }
  end

  def send_notifications!
    users = forum_thread.users.uniq - [user]
    users.each do |user|
      NotificationMailer.forum_post_notification(user, self).deliver_later
    end
  end

end
