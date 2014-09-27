class  Admin::WxUsersController < Admin::BaseController  
    def index
      @page_title = "微信订阅用户管理"
      @q = WxUser.search(params[:q])
      @wx_users = @q.result(distinct: true)
      @wx_users_grid = initialize_grid(@wx_users,:per_page => 20)
    end
end