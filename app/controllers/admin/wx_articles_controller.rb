class  Admin::WxArticlesController < Admin::BaseController  

  def index
    @page_title = "微信图文消息管理"
    @q = WxArticle.search(params[:q])
    @articles = @q.result(distinct: true)
    @articles_grid = initialize_grid(@articles,:per_page => 20)
  end
  
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