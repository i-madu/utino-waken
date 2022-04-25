class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_customer!,except:[:top]

   def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
       admin_customers_path
    else
       posts_path
    end
   end

   def after_sign_out_path_for(resouce_or_scope)
     if resouce_or_scope == :admin
         new_admin_session_path
     else
         root_path
     end
   end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:login_name])
  end
end