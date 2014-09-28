require 'digest/md5' 

class WxUser < ActiveRecord::Base
  validates :username,:password,:name,:phone,:presence => true
  validates :username, uniqueness: true
  
  belongs_to :wx_role
  
  def active_pay_user?
    
  end
  
  def encrypt_password
     Digest::MD5.hexdigest("#{self.username}#{self.password}")
  end
  
  
  def authenticate(password)
    try_password = Digest::MD5.hexdigest("#{self.username}#{password}")
    
    puts "#{self.password} & #{try_password}"
    try_password == self.password   
  end
end