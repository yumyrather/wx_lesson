module ApplicationHelper
  def active_menu(target)
    if ( controller_name && target.index(controller_name) )
      "active" 
    else
      ""
    end
  end  
end
