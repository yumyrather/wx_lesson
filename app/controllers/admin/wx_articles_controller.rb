class  Admin::WxArticlesController < Admin::BaseController  
  def index
    @page_title = "微信图文消息管理"
    @q = WxArticle.search(params[:q])
    @articles = @q.result(distinct: true).order("published_at")
    @articles_grid = initialize_grid(@articles,:per_page => 20)
  end
  
  def show
    @article = WxArticle.find(params[:id])
  end
  
  def new
    @article = WxArticle.new    
  end
  
  def edit
    @article = WxArticle.find(params[:id])
  end
  
  def create
    @article = WxArticle.new(wx_article_params)
    if @article.save
      redirect_to [:admin,@article],:notice=>"新建图文消息成功!"
    else
      render 'new'
    end
  end
  
  def update
    @article = WxArticle.find(params[:id])
    if @article.update(wx_article_params)
      redirect_to [:admin,@article],:notice=>"更新图文消息成功!"
    else
      render 'edit'
    end
  end
  
  def destroy
    @article = WxArticle.find(params[:id])
    
    @article.destroy
    redirect_to admin_wx_articles_path
  end
  
  private
  def wx_article_params
    params.require(:wx_article).permit!
  end
end