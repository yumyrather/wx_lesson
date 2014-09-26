class  Admin::WxLessonsController < Admin::BaseController  
    def index
      @page_title = "微信关键字管理"
      @q = WxLesson.search(params[:q])
      @lessons = @q.result(distinct: true)
      @lessons_grid = initialize_grid(@lessons,:per_page => 20)
    end
end