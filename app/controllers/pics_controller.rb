class PicsController < ApplicationController
  before_action :authenticate_user!
  def create
    @album = Album.find(params[:album_id])
    @pic = @album.pics.new(pic_params)
    if @pic.save
      render json: {messages: "success", uploadId: @pic.id}, status: 200
    else
      render json: {error: @pic.errors.full_messages.join(", ")}, status: 404
    end
  end

  def list
    @album ||= Album.find(params[:album_id])
    uploads = []
    @pics = @album.pics 
		@pics.each do |upload|
			new_upload = {
				id: upload.id,
				name: upload.image_file_name,
				size: upload.image_file_size,
				src: upload.image(:thumb)
			}
			uploads.push(new_upload)
    end
		render json: { images: uploads }
	end

  def destroy
    @pic = Pic.find(params[:id])
    if @pic.destroy
      render json: {message: "img delete from server"}
    else
      render json: {message: @pic.errors.full_messages.join(", ")}
    end
  end

  private
    def pic_params
      params.require(:pic).permit(:title, :description, :image)
    end
end
