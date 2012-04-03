class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    unless current_user.squad
      new_squad_path # You can put whatever path you want here
    else
      fleets_path
    end
  end

  def current_squad
    if current_user
      current_user.squad
    else
      'NO SQUAD'
    end
  end

end
