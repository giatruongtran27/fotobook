class ApplicationController < ActionController::Base
  # include SessionsHelper
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me, :first_name, :last_name]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
  def after_sign_out_path_for(*)
    new_user_session_path
  end

  def after_update_path_for(*)
    # edit_user_registration_path
    redirect_to edit_user_registration_path
  end

end
