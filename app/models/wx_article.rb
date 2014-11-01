class WxArticle < ActiveRecord::Base
  has_many :wx_keyword_items,dependent: :destroy
  mount_uploader :cover, ArticleCoverUploaderUploader
  
  def wx_cover
    if self.cover == "image.jpg"
      return self.cover_ur
    else
      return self.cover_url(:normal)
    end
  end
end