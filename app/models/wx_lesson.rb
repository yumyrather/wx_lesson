class WxLesson < ActiveRecord::Base
  has_many :wx_chapters
  has_many :wx_lesson_user_records
  has_many :wx_users,:through=>:wx_lesson_user_records
  validates :frequency,:presence => true
  validates :title, uniqueness: true

  mount_uploader :cover, ArticleCoverUploaderUploader
  Frequencies = ["每周","每月"]
  
  #
  # 用户对课程进行签到动作
  # 返回签最新的学习进度
  def sign_lesson(wx_user)
    if has_sign?(wx_user)
      return false
    end
    record = self.wx_lesson_user_records.find_by_wx_user_id(wx_user.id)
    
    if record
      if record.now_chatpter < self.wx_chapters.size
         record.now_chatpter += 1
      end
      record.last_signin = Time.now
      record.save
      return true
    else
      record = WxLessonUserRecord.new
      record.wx_lesson_id = self.id
      record.wx_user_id = wx_user.id
      record.now_chatpter = 1
      record.last_signin = Time.now
      record.save
      return true
    end
  end

  #
  # 判断是否在周期内是否连续签到
  #
  def has_sign?(user,time = Time.now)
    record = self.wx_lesson_user_records.find_by_wx_user_id(user.id)
    if record.nil?
      return false
    end
    
    if frequency == "每周"
      return record.last_signin + 7.day > time
    elsif frequency == "每月"
      return record.last_signin + 1.month > time
    else
      return false
    end
    
  end
  
  
end

