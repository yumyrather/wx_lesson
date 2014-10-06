class  Mobile::WxLessonsController < Mobile::BaseController  
    def show
      @lesson = WxLesson.find(params[:id])
      if current_wx_user
        @study_record = @lesson.wx_lesson_user_records.find_by_wx_user_id(current_wx_user.id)
        @chapters = @lesson.wx_chapters.where("no > 0 and no is not null and no <= ?",@study_record.now_chatpter).order("no asc")
      else
        @chapters = []  
      end
    end
end