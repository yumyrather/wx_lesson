class WxArticle < ActiveRecord::Base
  has_many :wx_keyword_items
end