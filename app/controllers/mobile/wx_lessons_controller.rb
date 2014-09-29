class  Mobile::WxLessonsController < Mobile::BaseController  
    def show
      @lesson = WxLesson.find(params[:id])
      @chapters = @lesson.wx_chapters.where("no is not null").order("no asc")
    end
end