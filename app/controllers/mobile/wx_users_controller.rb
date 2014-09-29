class  Mobile::WxUsersController < Mobile::BaseController  
  before_filter :same_user
    def show
      @user = WxUser.find(params[:id])
    end
    
    def same_user
       if not (current_wx_user && params[:id].to_i == current_wx_user.id)
         redirect_to mobile_root_path
       end
    end
end