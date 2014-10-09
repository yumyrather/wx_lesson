class  Admin::WxChaptersController < Admin::BaseController  
  def index
    @page_title = "系统管理员"
    @q = User.search(params[:q])
    @users = @q.result(distinct: true)
    @users_grid = initialize_grid(@users,:per_page => 20)
  end
  
end