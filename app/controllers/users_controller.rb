class UsersController < ApplicationController
  load_and_authorize_resource except: [:edit_add_follow] 
  layout "admin_layout", only: [:edit]
  before_action :authenticate_user!, only: [:index, :edit_add_follow, :create, :admin_only]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :get_followers, :edit_add_follow, :update_by_admin, :get_update_by_admin]
  before_action :admin_only, only: [:edit, :update_by_admin, :get_update_by_admin, :destroy]

  def index
    redirect_to current_user
  end

  def show
    if can? :manage, @user
      @list_photos = @user.photos.paginate(:page => params[:photos_page], :per_page => 4)
      @list_albums = @user.albums.paginate(:page => params[:albums_page], :per_page => 4)
    else
      @list_photos = @user.photos.public_mode.paginate(:page => params[:photos_page], :per_page => 4)    
      @list_albums = @user.albums.public_mode.paginate(:page => params[:albums_page], :per_page => 4)      
    end
    respond_to do |format|
      format.html
      format.js
    end
  end 

  def edit_add_follow
    begin
      @follower = User.find(params[:user_follow_id])
      @user = User.find(params[:id])
      # Do action follow or unfollow
      @action = FollowsService.call(current_user, @follower)
      # Check if at follower's profile
      @at_follower_profile = FollowsService.at_follower_profile? @follower, @user
      # Check if at your profile
      @at_your_profile = FollowsService.at_your_profile? current_user, @user 
      # Render
      if @action.eql? :unfollow
        render "users/follow_components/unfollow"
      end
      if @action.eql? :follow
        render "users/follow_components/follow"
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: {
        error: e.to_s
      }, status: :not_found
    end
  end
    
  # ADMIN ACTION ONLY
  def edit
    @manage_users = true
  end

  def get_update_by_admin
    redirect_to edit_user_path(@user)
  end

  def update_by_admin
    if params[:user][:password].blank?
      my_params = params.require(:user).permit(:first_name, :last_name, :email, :image, :admin)
    else
      params[:user][:password_confirmation] = params[:user][:password]
      my_params = params.require(:user).permit(:first_name, :last_name, :email, :image, :admin, :password, :password_confirmation)
    end

    respond_to do |format|
      if @user.update(my_params)
        format.html { redirect_to admin_edit_user_path(@user), notice: t('notice.user.update') }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_dashboard_path, notice: t('notice.user.destroy') }
      format.json { head :no_content }
    end
  end
  
  private
  def admin_only
    unless current_user.admin
      redirect_to error_422_path
    end
  end
  
  def set_user
    begin
      @user = User.includes(:photos => [:user], :albums => [:pics]).find(params[:id])
    rescue StandardError => e
      redirect_to error_404_path
    end
  end
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :image, :password, :password_confirmation)
  end
end

