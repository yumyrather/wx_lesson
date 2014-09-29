class WxChapter < ActiveRecord::Base
  belongs_to :wx_lesson
  mount_uploader :cover, ArticleCoverUploaderUploader
  
end