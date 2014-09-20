class  Admin::WxKeywordsController < Admin::BaseController  
    def index
      @page_title = "微信关键字管理"
      @q = WxKeyword.search(params[:q])
      @keywords = @q.result(distinct: true)
      @keywords_grid = initialize_grid(@keywords,:per_page => 20)
    end

end