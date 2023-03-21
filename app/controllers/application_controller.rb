class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  def after_sign_in_path_for(resource)
    case resource
    when User
      root_path  #　指定したいパスに変更
    when Admin
      admin_root_path
    else
      customers_my_page_path  #　指定したいパスに変更
    end
  end
  

  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address, :language, :introduction, :image_id])
  end
    
end
