class  Admin::WxLessonsController < Admin::BaseController  
    def index
      @page_title = "微信关键字管理"
      @q = WxLesson.search(params[:q])
      @lessons = @q.result(distinct: true)
      @lessons_grid = initialize_grid(@lessons,:per_page => 20)
    end
    
    def show
      @lesson = WxLesson.find(params[:id])
    end
    
    def new
      @lesson = WxLesson.new
    end
    
    
    def create
      @lesson = WxLesson.new(wx_lesson_params)
      if @lesson.save
        redirect_to [:admin,@lesson],:notice=>"新建课程主题成功!"
      else
        render 'new'
      end
    end
    
    private
    def wx_lesson_params
      params.require(:wx_lesson).permit!
    end
end