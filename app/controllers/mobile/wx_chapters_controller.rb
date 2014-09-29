class  Mobile::WxChaptersController < Mobile::BaseController  
    def show
      @chapter = WxChapter.find(params[:id])
    end
end