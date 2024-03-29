class  Admin::WxKeywordsController < Admin::BaseController  
    def index
      @page_title = "微信关键字管理"
      @q = WxKeyword.search(params[:q])
      @keywords = @q.result(distinct: true)
      @keywords_grid = initialize_grid(@keywords,:per_page => 20)
    end

    def show
      @keyword = WxKeyword.find(params[:id])
    end

    def new
      @keyword = WxKeyword.new
    end

    def create
      @keyword = WxKeyword.new(wx_keyword_params)
      if @keyword.save
        redirect_to [:admin,@keyword],:notice=>"新建关键字成功!"
      else
        render 'new'
      end
    end

    def edit
      @keyword = WxKeyword.find(params[:id])
    end

    def update
      @keyword = WxKeyword.find(params[:id]) 
      if @keyword.update(wx_keyword_params)
        redirect_to [:admin,@keyword],:notice=>"更新关键字成功!"
      else
        render 'edit'
      end
    end

    def destroy
      @keyword = WxKeyword.find(params[:id]) 
      @keyword.destroy
      redirect_to admin_wx_keywords_path,:notice=>"删除关键字成功!"
    end


    def wx_article_list
      @keyword = WxKeyword.find(params[:id])
      @articles = WxArticle.all
      @articles_grid = initialize_grid(@articles,:per_page => 20)
    end
    
    private
    def wx_keyword_params
      params.require(:wx_keyword).permit!
    end
end