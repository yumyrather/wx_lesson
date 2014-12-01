class Admin::WxMenusController <  Admin::BaseController
  def index
    
  end
  
  def new
    @menu = WxMenu.new
    if params[:parent_id].present?
      @menu.parent_id = params[:parent_id]
    end
    
    
  end
  
  
  def edit
    @menu = WxMenu.find(params[:id])
  end
  
  
  def create
    @menu = WxMenu.new(wx_menu_params)
    @menu.save
    @menus = WxMenu.parent_menus
  end
  
  def update
    @menu = WxMenu.find(params[:id])
    @success =  @menu.update(wx_menu_params)
    @menus = WxMenu.parent_menus
    
  end
  
  
  def destroy
    @menu = WxMenu.find(params[:id])
    @success = @menu.destroy
    @menus = WxMenu.parent_menus
  end
  
  
  def fetch
    $client = get_client
    menus_list = $client.menu
    if menus_list.is_ok?
      response = menus_list.result
    end
    
    render :text => response
  end
  
  def push
    @menus = WxMenu.build_menu
    $client = get_client
    response = $client.create_menu(@menus)
    @success = response.is_ok?
    if @success
      logger.info("operation ok")
    end
  end
  
  
  def get_client
    $client ||= WeixinAuthorize::Client.new(Configs.app_id, Configs.app_secret)
  end
  
  
  private 
  
  def wx_menu_params
    params.require(:wx_menu).permit!
  end
end