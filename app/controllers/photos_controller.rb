class PhotosController < ApplicationController
  before_action :authenticate_user! , only: [:check_authorize, :like]
  before_action :check_authorize, only: [:show, :create, :new, :edit, :update, :destroy]
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :like]
  
  # GET /photos
  # GET /photos.json
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
        render json: { messages: "You have unliked photo: #{@photo.title}", type: "unlike"}, status: 200
      else
        @photo.likes.create(user_id: current_user.id)
        render json: { messages: "You have liked photo: #{@photo.title}", type: "like"}, status: 200 
      end
    rescue StandardError => e
      render json: {
        error: e.to_s
      }, status: :not_found
    end
  end 

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = @user.photos.build
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    # current_user = User.find(1)
    params[:sharing_mode] = params[:sharing_mode] == "1"
    @user = User.find(params[:user_id])
    @photo = @user.photos.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to user_photo_path(@photo.user, @photo), notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to user_photo_path(@photo.user, @photo), notice: 'Photo was successfully updated.' }
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
      format.html { redirect_to user_photos_url, notice: 'Photo was successfully destroyed.' }
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
