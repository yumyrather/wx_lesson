class WxKeywordItem < ActiveRecord::Base
  belongs_to :wx_keyword
  belongs_to :wx_article
end