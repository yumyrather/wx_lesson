class WxChapter < ActiveRecord::Base
  belongs_to :wx_lesson
  mount_uploader :cover, ArticleCoverUploaderUploader
  validates :title,:presence => true
  
end