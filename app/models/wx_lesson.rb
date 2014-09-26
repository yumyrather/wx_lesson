class WxLesson < ActiveRecord::Base
  has_many :wx_chapters
  mount_uploader :cover, ArticleCoverUploaderUploader
  
end

