class  Mobile::WxArticlesController < Mobile::BaseController  
  layout "mobile_article"
    def show
      @article = WxArticle.find(params[:id])
      @article.increment_view_count
      
    end
end