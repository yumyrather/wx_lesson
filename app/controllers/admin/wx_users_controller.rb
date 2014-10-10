class  Admin::WxUsersController < Admin::BaseController  
    def index
      @page_title = "微信订阅用户管理"
      @q = WxUser.search(params[:q])
      @wx_users = @q.result(distinct: true)
      @wx_users_grid = initialize_grid(@wx_users,:per_page => 20)
    end
    
    def show
      @wx_user = WxUser.find(params[:id])
    end
    
    def new
      @wx_user = WxUser.new
    end

    def edit
      @wx_user = WxUser.find(params[:id])
    end
    
    def create
      @wx_user = WxUser.new(wx_user_params)
      @wx_user.password = @wx_user.encrypt_password
      if @wx_user.save
        redirect_to [:admin,@wx_user],:notice=>"新建微信订阅用户成功!"
      else
        render 'new'
      end
    end
    
    def update
      @wx_user = WxUser.find(params[:id])
      if params[:wx_user][:password].present?
        @wx_user.update(wx_user_params)
        @wx_user.password = @wx_user.encrypt_password
        
      else
        @wx_user.update(wx_user_params.delete(:password))
      end
      
      if @wx_user.save
        redirect_to [:admin,@wx_user],:notice=>"更新微信订阅用户成功!"
      else
        render 'edit'
      end
    end
    
    def destroy
      @wx_user = WxUser.find(params[:id])
      @wx_user.destroy
      redirect_to admin_wx_users_path,:notice=>"删除微信订阅用户成功!"
    end
    
    private
    def wx_user_params
      params.require(:wx_user).permit!
    end
end