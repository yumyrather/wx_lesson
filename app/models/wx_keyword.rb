class WxKeyword < ActiveRecord::Base
  validates :keyword,:presence => true
  validates :keyword, uniqueness: true
  
  REPLY_TYPES = ["图文","文本"]
  ACTIVE_TYPES = [["激活",0],["失效",1]]
  has_many :wx_keyword_items,dependent: :destroy
  has_many :wx_articles,:through=>:wx_keyword_items
  
  scope :actives, -> { where(hidden: false) }
  
  def active?
    self.hidden != true
  end
end