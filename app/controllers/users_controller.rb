class UsersController < ApplicationController
  layout "admin_layout", only: [:edit]
  before_action :authenticate_user!, only: [:index, :edit_add_follow, :create, :edit, :admin_only, :check_authorize]
  before_action :check_authorize, only: [:create, :edit, :update, :destroy]  
  before_action :set_user, only: [:show, :edit, :update, :destroy, :get_followers, :edit_add_follow, :update_by_admin, :get_update_by_admin]
  before_action :admin_only, only: [:edit, :update_by_admin, :get_update_by_admin, :destroy]
  def index
    redirect_to current_user
  end

  def show
    if current_user and (current_user.id.equal? @user.id or current_user.admin?)
      @list_photos = @user.photos
      @list_albums = @user.albums
      @full_authorities_for_this_user = true
    else
      @list_photos = @user.photos.public_mode;
      @list_albums = @user.albums.public_mode;
      @full_authorities_for_this_user = false    
    end
  end 
  
  # PATCH/PUT /users/edit
  # UPDATE SELF PROFILE
  # def update
  #   respond_to do |format|
  #     if @user.update_without_password(user_params)
  #       format.html { redirect_to edit_user_registration_path, notice: 'User was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @user }
  #     else
  #       format.html { render 'devise/registrations/edit' }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def edit_add_follow
    begin
      @follower = User.find(params[:user_follow_id])
      follow_user =  @follower.as_json(only: [:id, :last_name, :first_name])
      follow_user_img = @follower.image.url
      size_of_photos_albums = {"photos": @follower.photos.size, "albums": @follower.albums.size }
      check_is_this_user = current_user.id.to_i.equal? params[:id].to_i
      check_its_you_action_to_other_profile =  @follower.id.equal? params[:id].to_i
      # you
      your_profile = current_user.as_json(only: [:id, :last_name, :first_name])
      your_image = current_user.image.url
      your_photos  = current_user.photos.size
      your_albums  = current_user.albums.size
      you = {
        your_profile: your_profile,
        your_image: your_image,
        your_photos: your_photos,
        your_albums: your_albums
      }
      #
      if current_user.followers.include? @follower #case: unfollow
        begin
          current_user.followers.delete(@follower)
          render json: { you: you, check_its_you_action_to_other_profile: check_its_you_action_to_other_profile, check_is_this_user: check_is_this_user, messages: "You have unfollowed #{@follower.last_name.capitalize} #{@follower.first_name.capitalize}", follow_user: follow_user, follow_user_img: follow_user_img, size_of_photos_albums: size_of_photos_albums, type: "unfollow"}, status: 200
        rescue StandardError => e
          render json: {
            error: e.to_s
          }, status: :not_found
        end
      else # case follow
        begin
          current_user.followers << @follower
          render json: { you: you, check_its_you_action_to_other_profile: check_its_you_action_to_other_profile, check_is_this_user: check_is_this_user, messages: "You have followed #{@follower.last_name.capitalize} #{@follower.first_name.capitalize}", follow_user: follow_user, follow_user_img: follow_user_img, size_of_photos_albums: size_of_photos_albums, type: "follow"}, status: 200
        rescue StandardError => e
          render json: {
            error: e.to_s
          }, status: :not_found
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: {
        error: e.to_s
      }, status: :not_found
    end
    # render json: {errors: @follower.errors.full_messages.join(", ")}, status: 404
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
        format.html { redirect_to admin_edit_user_path(@user), notice: 'User was successfully updated.' }
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
      format.html { redirect_to admin_dashboard_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  ######
  private
    def admin_only
      unless current_user and  current_user.admin
        render :file => "#{Rails.root}/public/422.html",  :status => 422, layout: 'errors_layout'
      end
    end

    def check_authorize
      unless current_user.id == params[:id].to_i or current_user.admin
        render :file => "#{Rails.root}/public/422.html",  :status => 422, layout: 'errors_layout'
      end 
    end 
    def set_user
      begin
        @user = User.find(params[:id])
      rescue
        render :file => "#{Rails.root}/public/404.html",  :status => 404, layout: 'errors_layout'
      end
    end
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :image, :password, :password_confirmation)
    end
end

