class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    unless current_user.squad
      new_squad_path # You can put whatever path you want here 
    else
      root_path
    end
  end

  def current_squad
    current_user.squad  
  end


end
