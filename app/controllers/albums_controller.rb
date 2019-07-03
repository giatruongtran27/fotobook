class AlbumsController < ApplicationController
  before_action :authenticate_user! #, only: [:add_image, :create, :new, :edit, :update, :destroy]
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.all
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
    @album = current_user.albums.create(album_params)
    def insert_data
      # puts "aaaaaaaaaaaaaaaaaaaaa"
      ActiveRecord::Base.transaction do
        params[:pics]["image"].each do |i|
          @img = Pic.create image: i
          @img.album = @album
          @img.save
        end
      end 
    end
    #
    insert_data
    redirect_to user_album_path(@album.user, @album)
    # 
    # respond_to do |format|
    #   if @album.save
    #     format.html { redirect_to user_album_path(@album.user, @album), notice: 'Album was successfully created.' }
    #     format.json { render :show, status: :created, location: @album }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @album.errors, status: :unprocessable_entity }
    #   end
    # end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:title, :description, pics_attributes: [:id, :title, :description, :image])
      # params.fetch(:album, {})
    end
  end
