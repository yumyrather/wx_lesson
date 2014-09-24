class WxKeyword < ActiveRecord::Base
  validates :keyword,:presence => true
  validates :keyword, uniqueness: true
  
  REPLY_TYPES = ["图文","文本"]
  has_many :wx_keyword_items
  has_many :wx_articles,:through=>:wx_keyword_items
  
end