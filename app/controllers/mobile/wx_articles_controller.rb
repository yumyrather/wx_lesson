class  Mobile::WxArticlesController < Mobile::BaseController  
  layout "mobile_article"

    def show
      @article = WxArticle.find(params[:id])
      @article.increment_view_count
    end
    
    def like
      @article = WxArticle.find(params[:id])
      session["article_like_#{@article.id}"] = true
      @article.like_count += 1
      @article.save
    end
    
    def share
      @article = WxArticle.find(params[:id])
      @article.share_count += 1
      @article.save
    end
end