class  Admin::WxChaptersController < Admin::BaseController  
  def new
    @chapter = WxChapter.new
    @chapter.wx_lesson_id = params[:lesson_id]
  end
end