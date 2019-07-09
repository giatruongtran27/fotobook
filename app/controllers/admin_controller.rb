class AdminController < ApplicationController
  layout "admin_layout"
  before_action :authenticate_user!, only: [:is_admin]
  before_action :is_admin
  before_action :set_photo, only: [:edit_photo, :update_photo, :destroy_photo]
  before_action :set_album, only: [:edit_album, :update_album, :destroy_album]

  def index
    self.users
  end

  def users
    @users = User.all
    @manage_users = true
  end
  
  def photos
    @photos = Photo.all
    @manage_photos = true
  end

  def albums
    @albums = Album.all
    @manage_albums = true
  end

  def edit_photo
    @manage_photos = true
  end

  def update_photo
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to admin_photos_path, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit_photo }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_photo
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to admin_photos_path, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit_album
    @manage_albums = true
  end

  def update_album
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to admin_albums_path, notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit_album }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy_album
    @album.destroy
    respond_to do |format|
      format.html { redirect_to admin_albums_path, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_pic
    @pic = Pic.find(params[:id])
    if @pic.destroy
      render json: {message: "img delete from server"}
    else
      render json: {message: @pic.errors.full_messages.join(", ")}
    end
  end

  private
    def is_admin
      unless current_user and  current_user.admin
        render :file => "#{Rails.root}/public/422.html",  :status => 422
      end 
    end

    def set_photo
      @photo = Photo.find(params[:id])
    end
    
    def set_album
      @album = Album.find(params[:id])
    end

    def photo_params
      params.require(:photo).permit(:title, :description, :sharing_mode, :image)
    end

    def album_params
      params.require(:album).permit(:title, :description, :sharing_mode, pics_attributes: [:id, :title, :description, :image])
    end
end
