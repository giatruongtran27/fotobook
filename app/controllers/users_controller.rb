class UsersController < ApplicationController
  # layout "s_layout"
  before_action :authenticate_user!, only: [:edit_add_follow]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :get_followers, :edit_add_follow]

  def index
  end

  def show
  end

  def edit
  end

  # PATCH/PUT /users/edit
  # UPDATE SELF PROFILE
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_user_registration_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

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

  private
    def set_user
      @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :image)
    end
end

