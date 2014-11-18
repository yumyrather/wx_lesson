class  Admin::SettingsController < Admin::BaseController  

  def index
    @q = Setting.search(params[:q])
    @settings = @q.result(distinct: true)
    @settings_grid = initialize_grid(@settings,:per_page => 50)
  end
  
  def show
    @settings = Setting.find(params[:id]) 
  end
  
  def new
    @setting = Setting.new

  end

  def create
    @setting = Setting.new(setting_params) 
    if @setting.save
      redirect_to admin_settings_path,:notice=>"新建系统参数成功!"
    else
      render 'new'
    end
  end

  def edit
    @setting = Setting.find(params[:id]) 
  end

  def update
    @setting = Setting.find(params[:id]) 
    if @setting.update(setting_params)
      redirect_to admin_settings_path,:notice=>"更新系统参数"
    else
      render 'edit'
    end
  end

  def destroy
    @setting = Setting.find(params[:id]) 
    @setting.destroy
    redirect_to back_path ,:alert=>"删除系统参数成功"
  end

  private
  def setting_params
    params.require(:setting).permit!
  end


end