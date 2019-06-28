class PhotosController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index, :add_image]
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:delete_image]
  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    # current_user = User.find(1)
    @photo = @current_user.photos.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_image
    puts params[:album_id]
    puts "--------------IMG-------------"
    puts params[:image]
    puts "--------------IMG-------------"

    album ||= Album.find_by_id(params[:album_id])
    puts "--------------album-------------"
    puts album
    puts album.id
    puts album.title
    # @current_user ||= User.find_by_id(session[:user_id])
    # puts "--------------user-------------"
    # puts @current_user
    # puts @current_user.email
    puts current_user.email
    # params[:title] = "title"
    # params[:description] = "des"
    @photo = @current_user.photos.new(params.require(:photo).permit( :image))
    puts "--------------photo-------------"
    puts @photo
    puts "--------------end puts-------------"
    if @photo.save
      render json: {message: "success", uploadId: @photo.id}, status: 200
    else
      render json: {error: @photo.errors.full_messages.join(", ")}, status: 400
    end
    puts @photo.id

    album.photos << @photo

    # album.photos << @photo
    # puts params[:image]
  end

  def delete_image
    puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    @photo = Photo.find(params[:id])
    @album ||= Album.find_by_id(params[:album_id])
    @photo.albums.delete(@album)

    if @photo.destroy
      render json: { message: "file deleted from server" }
    else
      render json: { message: @photo.errors.full_messages.join(", ") }
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      # @current_user ||= User.find_by_id(session[:user_id])
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:title, :description, :image)
      # params.fetch(:photo, {})
    end
end
