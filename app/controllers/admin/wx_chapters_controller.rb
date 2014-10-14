class  Admin::WxChaptersController < Admin::BaseController  
  def index
    @page_title = "课程章节管理"
    @q = WxChapter.search(params[:q])
    @chapters = @q.result(distinct: true)
    @chapters_grid = initialize_grid(@chapters,:per_page => 20)
  end
  
  def show
    @chapter = WxChapter.find(params[:id])
  end
  
  
  def new
    @chapter = WxChapter.new
    @chapter.wx_lesson_id = params[:lesson_id]
  end
  
  
  def edit
    @chapter = WxChapter.find(params[:id])
  end
  
  def create
    @chapter = WxChapter.new(wx_chatper_params)
    
    if @chapter.save
      redirect_to wx_chapter_list_admin_wx_lesson_path(@chapter.wx_lesson_id),:notice=>"新建课程章节成功!"
    else
      render 'new'
    end
  end
  
  
  def update
    @chapter = WxChapter.find(params[:id])
    if @chapter.update(wx_chatper_params)
      redirect_to wx_chapter_list_admin_wx_lesson_path(@chapter.wx_lesson_id),:notice=>"更新课程章节成功!"
    else
      render 'edit'
    end
  end
  
  
  def destroy
    @chapter = WxChapter.find(params[:id])
    @lesson_id = @chapter.wx_lesson_id
    @chapter.destroy
    redirect_to admin_wx_lesson_path(@lesson_id),:notice=>"删除课程章节成功!"
  end
  
  
  private
  def wx_chatper_params
    params.require(:wx_chapter).permit!
  end
  
end