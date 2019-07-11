class AlbumsController < ApplicationController
  before_action :authenticate_user! , only: [:check_authorize, :like]
  before_action :check_authorize, only: [:show, :create, :new, :edit, :update, :destroy]
  before_action :set_album, only: [:show, :edit, :update, :destroy, :like, :images]

  # GET /albums
  # GET /albums.json
  def index
    if current_user.id == params[:user_id].to_i || current_user.admin
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
        obj = {
          image: pic.image.url,
          title: pic.image_file_name
        }
        pics.push obj
      end
      has_images = true
    end
    render json: {
      messages: "success",
      size_images: size_images,
      has_images: has_images,
      pics: pics,
      title: @album.title,
      description: @album.description
    }
  end

  def like 
    begin
      check_like = @album.likes.find_by(user_id: current_user)
      if check_like
        check_like.delete
        render json: { messages: "You have unliked photo: #{@album.title}", type: "unlike"}, status: 200
      else
        @album.likes.create(user_id: current_user.id)
        render json: { messages: "You have liked photo: #{@album.title}", type: "like"}, status: 200 
      end
    rescue StandardError => e
      render json: {
        error: e.to_s
      }, status: :not_found
    end
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @pics ||= @album.pics
  end

  # GET /albums/new
  def new
    @album = Album.new 
    @album.pics.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    begin
      @user = User.find(params[:user_id])
      @album = @user.albums.create(album_params)
      def insert_data
        ActiveRecord::Base.transaction do
          params[:pics]["image"].each do |i|
            @img = Pic.create image: i
            @img.album = @album
            @img.save
          end
        end 
      end
      #
      if params[:pics] and params[:pics]["image"].size > 0
        insert_data
      end 
      redirect_to user_album_path(@album.user, @album), notice: 'Album was successfully created.'  
    rescue => e      
      redirect_to new_user_album_path(@album.user), alert: 'Album created failed. Please try again.' 
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to user_album_path(@album.user, @album), notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to user_albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def check_authorize
      if current_user.id != params[:user_id].to_i and !current_user.admin
        render :file => "#{Rails.root}/public/422.html",  :status => 422
      end 
    end 

    def set_album
      begin
        @album = Album.find(params[:id])
      rescue
        render :file => "#{Rails.root}/public/404.html",  :status => 404, layout: 'errors_layout'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:title, :description, :sharing_mode, pics_attributes: [:id, :title, :description, :image])
      # params.fetch(:album, {})
    end
  end
