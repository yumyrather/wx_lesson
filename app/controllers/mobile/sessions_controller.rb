class Mobile::SessionsController < Mobile::BaseController
  layout 'mobile_article'
  def new
  end

  def create
    user = WxUser.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      wx_sign_in user
      user.update_attribute(:ip, request.remote_ip)
      if current_weichat_id
        user.update_attribute(:open_id,current_weichat_id)
      end
      redirect_back_or mobile_wx_user_path(user)
    else
      flash.now[:error] = "密码错误"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end