class Mobile::BaseController < ApplicationController
  layout "mobile"
  before_filter :set_weichat_id


end

