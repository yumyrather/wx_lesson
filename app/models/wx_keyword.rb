class WxKeyword < ActiveRecord::Base
  validates :keyword,:presence => true
end