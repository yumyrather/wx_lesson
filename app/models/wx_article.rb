class WxArticle < ActiveRecord::Base
  has_many :wx_keyword_items
  mount_uploader :cover, ArticleCoverUploaderUploader
end