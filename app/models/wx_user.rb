require 'digest/md5' 

class WxUser < ActiveRecord::Base
  validates :username,:password,:name,:phone,:presence => true
  validates :username, uniqueness: true
  
  belongs_to :wx_role
  
  def encrypt_password
     Digest::MD5.hexdigest("#{self.username}#{self.password}")
  end
  
end