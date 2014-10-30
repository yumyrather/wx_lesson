class  Mobile::WxArticlesController < Mobile::BaseController  
  layout "mobile_article"
    def show
      @article = WxArticle.find(params[:id])
    end
end