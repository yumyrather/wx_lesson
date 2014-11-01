class WxArticle < ActiveRecord::Base
  has_many :wx_keyword_items,dependent: :destroy
  mount_uploader :cover, ArticleCoverUploaderUploader
  

end