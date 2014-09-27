require 'digest/md5' 

class WxUser < ActiveRecord::Base
  
  def encrypt_password
     Digest::MD5.hexdigest("#{self.username}#{self.password}")
  end
  
end