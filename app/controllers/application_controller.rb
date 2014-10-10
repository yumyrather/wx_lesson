class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include MobileHelper

   def set_weichat_id
     if params[:weichat_id].present?
       session[:weichat_id] = params[:weichat_id]
       logger.info("weichat_id = #{session[:weichat_id]}")
     end
  end
  
  def current_weichat_id
    session[:weichat_id]
  end
end
