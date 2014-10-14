class WxLesson < ActiveRecord::Base
  has_many :wx_chapters
  has_many :wx_lesson_user_records
  has_many :wx_users,:through=>:wx_lesson_user_records
  validates :title, uniqueness: true
  
  mount_uploader :cover, ArticleCoverUploaderUploader
  
end

