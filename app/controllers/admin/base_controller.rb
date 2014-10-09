class Admin::BaseController < ApplicationController
  layout "admin"
  
  before_filter :authenticate_user!,:admin?
  
  
  def admin?
    if current_user.admin?
      return true
    else
      redirect_to root_path
    end
  end
end

