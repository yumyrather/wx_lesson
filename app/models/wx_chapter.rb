class WxChapter < ActiveRecord::Base
  belongs_to :wx_lesson
  mount_uploader :cover, ArticleCoverUploaderUploader
  validates :title,:presence => true
  validates :no, numericality: { only_integer: true,:greater_than_or_equal_to=>1 } ,if: "no.present?"
  
end