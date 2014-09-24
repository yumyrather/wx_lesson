class  Admin::WxKeywordItemsController < Admin::BaseController  
  def create
    @success = false
    if params[:article_id].present? && params[:keyword_id].present?
      @wx_keyword_item =  WxKeywordItem.new
      @wx_keyword_item.wx_article_id = params[:article_id]
      @wx_keyword_item.wx_keyword_id = params[:keyword_id]
       @success = @wx_keyword_item.save
    end
  end
  
  
  def destroy
    @wx_keyword_item = WxKeywordItem.find(params[:id]) 
    @article = @wx_keyword_item.wx_article
    @keyword = @wx_keyword_item.wx_keyword
    
    @wx_keyword_item.destroy
  end
end