class  Admin::WxArticlesController < Admin::BaseController  

  def show
    @article = WxArticle.find(params[:id])
  end
  
  def new
    @article = WxArticle.new    
  end
  
  def create
    @article = WxArticle.new(wx_article_params)
    if @article.save
      redirect_to [:admin,@article],:notice=>"新建图文消息成功!"
    else
      render 'new'
    end
  end
  
  private
  def wx_article_params
    params.require(:wx_article).permit!
  end
end