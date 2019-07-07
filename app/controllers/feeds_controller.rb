class FeedsController < ApplicationController
  before_action :authenticate_user!, only: [:feeds, :feeds_photos, :feeds_albums]
  def feeds
    self.feeds_photos
  end
  
  def feeds_photos
    followers_ids = current_user.followers.ids
    @photos = Photo.where(user_id: followers_ids).paginate(:page => params[:page], :per_page => 4).order('created_at DESC')
    @active_feeds = 1
    @active_photo_tag = 1
    render 'index'
  end

  def feeds_albums
    followers_ids = current_user.followers.ids
    @albums = Album.where(user_id: followers_ids).paginate(:page => params[:page], :per_page => 4).order('created_at DESC')    
    @active_feeds = 1
    @active_album_tag = 1
    render 'index'
  end

  def discover
    self.discover_photos
  end

  def discover_photos
    @photos = Photo.paginate(:page => params[:page], :per_page => 4).order('created_at DESC')
    @active_discover = 1
    @active_photo_tag = 1
    render 'index'
  end

  def discover_albums
    @albums = Album.paginate(:page => params[:page], :per_page => 4).order('created_at DESC')
    @active_discover = 1
    @active_album_tag = 1
    render 'index'
  end
end
