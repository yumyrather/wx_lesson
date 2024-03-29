class  Admin::UsersController < Admin::BaseController  
  
  def show
    @user = User.find(params[:id])
  end
  
  def index
    @page_title = "系统管理员"
    @q = User.search(params[:q])
    @users = @q.result(distinct: true)
    @users_grid = initialize_grid(@users,:per_page => 20)
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(wx_user_params)
    
    if @user.save
      redirect_to [:admin,@user],:notice=>"新管理员成功!"
    else
      render 'new'
    end
  end
  
  
  def update
    @user = User.find(params[:id])
    if @user.update(wx_user_params)
      redirect_to [:admin,@user],:notice=>"更管理员信息成功!"
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path,:notice=>"删除管理员成功!"
  end
  
  
  def change_password
    @user = User.find(params[:id])
  end
  
  def update_password
    @user = User.find(params[:id])
    if @user.update(wx_user_params)
      redirect_to [:admin,@user],:notice=>"更管理员信息成功!"
    else
      render 'change_password'
    end
  end
  private
  def wx_user_params
    params.require(:user).permit!
  end
end