class Mobile::SessionsController < ApplicationController
  layout 'mobile'
  def new
  end

  def create
    user = WxUser.find_by(username: params[:session][:username])
    
    if user && user.authenticate(params[:session][:password])
      wx_sign_in user
      user.update_attribute(:ip, request.remote_ip)
      redirect_back_or mobile_root_path
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