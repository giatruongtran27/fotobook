module SessionsHelper
  #Check if user has logged in?
  def is_logged?
    get_current_user.present?
  end

  #Save user_id to Session after logging
  def log_in(user)
    session[:user_id] = user.id
  end

  #Return current logged-in user
  def get_current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  #Log out
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
