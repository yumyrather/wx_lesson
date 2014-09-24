class  Mobile::WxArticlesController < Mobile::BaseController  
    def show
      @article = WxArticle.find(params[:id])
    end
end