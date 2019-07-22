class AlbumsController < ApplicationController
  before_action :authenticate_user!, only: [:check_authorize, :like]
  before_action :check_authorize, only: [:show, :create, :new, :edit, :update, :destroy]
  before_action :set_album, only: [:show, :edit, :update, :destroy, :like, :images]

  def index
    if UsersService.check_authorize?(current_user, params[:user_id])
      @user = User.find(params[:user_id])
      @albums = @user.albums
    else
      redirect_to user_path(params[:user_id])
    end
  end

  def images 
    pics = []
    has_images = false
    size_images = @album.pics.size
    if size_images > 0
      @album.pics.each do |pic|
        obj = { image: pic.image.url, title: pic.image_file_name}
        pics.push obj
      end
      has_images = true
    end
    render json: { messages: "success", size_images: size_images, has_images: has_images, pics: pics, title: @album.title, description: @album.description}
  end

  def like 
    begin
      check_like = @album.likes.find_by(user_id: current_user)
      if check_like
        check_like.delete
        render json: { messages: t('like.you_have_unliked', obj: @album.title), type: "unlike"}, status: 200
      else
        @album.likes.create(user_id: current_user.id)
        render json: { messages: t('like.you_have_liked', obj: @album.title), type: "like"}, status: 200 
      end
    rescue StandardError => e
      render json: {
        error: e.to_s
      }, status: :not_found
    end
  end

  def show
    @pics ||= @album.pics
  end

  def new
    @user = User.find(params[:user_id])
    @album = Album.new 
    @album.pics.new
  end

  def edit
  end

  def create
    begin
      @user = User.find(params[:user_id])
      @album = @user.albums.create(album_params)
      def insert_data
        params[:pics]["image"].each do |i|
          @img = Pic.create image: i
          @img.album = @album
          @img.save
        end 
      end
      if params[:pics] and params[:pics]["image"].size > 0
        insert_data
      end 
      redirect_to user_album_path(@album.user, @album), notice: t('notice.album.create')  
    rescue => e      
      redirect_to new_user_album_path(@album.user), alert: t('notice.album.failed')
    end
  end

  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to user_album_path(@album.user, @album), notice: t('notice.album.update') }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to user_albums_url, notice: t('notice.album.destroy') }
      format.json { head :no_content }
    end
  end

  private
  def check_authorize
    unless UsersService.check_authorize?(current_user, params[:user_id])
      redirect_to error_422_path
    end
  end 

  def set_album
    begin
      @album = Album.find(params[:id])
      @user = @album.user
    rescue
      redirect_to error_404_path
    end
  end

  def album_params
    params.require(:album).permit(:title, :description, :sharing_mode, pics_attributes: [:id, :title, :description, :image])
  end
end
