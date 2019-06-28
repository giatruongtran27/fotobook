class SessionsController < ApplicationController
  # layout "s_layout"
  # def new
  #   render 'new'
  # end

  # def create
  #   user = User.find_by(email: params[:session][:email].downcase)
  #   if user && user.authenticate(params[:session][:password])
  #     flash.now[:'alert-success'] = "Login successfully."
  #     log_in(user)
  #     redirect_to user
  #   else
  #     flash.now[:'alert-danger'] = 'Email or Password does not match.'
  #     render 'new'
  #   end
  # end

  # def destroy
  #   log_out
  #   redirect_to root_url
  # end

end
