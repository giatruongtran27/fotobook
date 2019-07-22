class PhotosController < ApplicationController
  before_action :authenticate_user! , only: [:check_authorize, :like]
  before_action :check_authorize, only: [:show, :create, :new, :edit, :update, :destroy]
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :like]
  
  def index
    if current_user.id == params[:user_id].to_i || current_user.admin
      @user = User.find(params[:user_id])
      @photos = @user.photos
    else
      redirect_to user_path(params[:user_id])
    end
  end

  def like
    begin
      check_like = @photo.likes.find_by(user_id: current_user)
      if check_like
        check_like.delete
        render json: { messages: t('like.you_have_unliked', obj: @photo.title), type: "unlike"}, status: 200
      else
        @photo.likes.create(user_id: current_user.id)
        render json: { messages: t('like.you_have_liked', obj: @photo.title), type: "like"}, status: 200 
      end
    rescue StandardError => e
      render json: {
        error: e.to_s
      }, status: :not_found
    end
  end 

  def show
  end

  def new
    @user = User.find(params[:user_id])
    @photo = @user.photos.build
  end

  def edit
  end

  def create
    params[:sharing_mode] = params[:sharing_mode] == "1"
    @user = User.find(params[:user_id])
    @photo = @user.photos.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to user_photo_path(@photo.user, @photo), notice: t('notice.photo.create') }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to user_photo_path(@photo.user, @photo), notice: t('notice.photo.update') }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to user_photos_url, notice: t('notice.photo.destroy') }
      format.json { head :no_content }
    end
  end

  private
    def check_authorize
      if current_user.id != params[:user_id].to_i and !current_user.admin
        render :file => "#{Rails.root}/public/422.html",  :status => 422, layout: 'errors_layout'
      end 
    end   

    def set_photo
      begin
        @user = User.find(params[:user_id])
        @photo = Photo.find(params[:id])
      rescue
        render :file => "#{Rails.root}/public/404.html",  :status => 404, layout: 'errors_layout'
      end
    end

    def photo_params
      params.require(:photo).permit(:title, :description, :sharing_mode, :image)
    end
end
