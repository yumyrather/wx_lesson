class WxKeywordItem < ActiveRecord::Base
  belongs_to :wx_keyword
  belongs_to :wx_article
  
  validates :wx_keyword_id, uniqueness: { scope: :wx_article_id,
      message: "不可重复绑定" }
      
end