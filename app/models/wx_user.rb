require 'digest/md5' 

class WxUser < ActiveRecord::Base
  validates :username,:password,:name,:phone,:presence => true
  validates :username, uniqueness: true
  
  belongs_to :wx_role
  OK_STATUS = "正常"
  BLOCK_STATUS = "停用"
  STATUS = ["正常","停用"]
  
  def active?
    if self.end_time
      Time.now < self.end_time
    else
      self.status != WxUser::BLOCK_STATUS
    end
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