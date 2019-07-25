class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to error_404_path, :alert => exception.message
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to error_422_path, :alert => exception.message
  end

  protected
  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :current_password, :image]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
  
  def after_sign_out_path_for(*)
    new_user_session_path
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
      { locale: I18n.locale }
  end

end
