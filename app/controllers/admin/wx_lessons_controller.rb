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
    
    def edit
      @lesson = WxLesson.find(params[:id])
    end
    
    
    def create
      @lesson = WxLesson.new(wx_lesson_params)
      if @lesson.save
        redirect_to [:admin,@lesson],:notice=>"新建课程主题成功!"
      else
        render 'new'
      end
    end
    
    
    def update
      @lesson = WxLesson.find(params[:id])
      if @lesson.update(wx_lesson_params)
        redirect_to [:admin,@lesson],:notice=>"更新图文消息成功!"
      else
        render 'edit'
      end
    end

    def destroy
      @lesson = WxLesson.find(params[:id])
      @lesson.destroy
      redirect_to admin_wx_lessons_path
    end
    
    def wx_chapter_list
      @lesson = WxLesson.find(params[:id])
      @chapters = @lesson.wx_chapters.order("no asc")
      @chapters_grid = initialize_grid(@chapters,:per_page => 20)
    end
    
    private
    def wx_lesson_params
      params.require(:wx_lesson).permit!
    end
end