class  Admin::WxChaptersController < Admin::BaseController  
  def show
    @article = WxChapter.find(params[:id])
  end
  
  
  def new
    @chapter = WxChapter.new
    @chapter.wx_lesson_id = params[:lesson_id]
  end
  
  def create
    @chapter = WxChapter.new(wx_chatper_params)
    
    if @chapter.save
      redirect_to wx_chapter_list_admin_wx_lesson_path(@chapter.wx_lesson_id),:notice=>"新建课程章节成功!"
    else
      render 'new'
    end
  end
  
  
  private
  def wx_chatper_params
    params.require(:wx_chapter).permit!
  end
  
end