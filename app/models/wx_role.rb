class WxRole < ActiveRecord::Base
  validates :name,:presence => true
  has_many :wx_users
  
end