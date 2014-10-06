class WxLessonUserRecord < ActiveRecord::Base
  belongs_to :wx_lesson
  belongs_to :wx_user
end