class FeedsController < ApplicationController
  before_action :authenticate_user!, only: [:feeds, :feeds_photos, :feeds_albums]
  def feeds
    if params[:search].present? #SEARCH
      followers_ids = current_user.followers.ids
      @search = params[:search].strip
      @photos = Photo.includes(:user).public_mode.where(user_id: followers_ids).where("title LIKE ?", "%#{@search}%").paginate(:page => params[:page], :per_page => 4).order('created_at DESC')
      @albums = Album.includes(:user).public_mode.where(user_id: followers_ids).where("title LIKE ?", "%#{@search}%").paginate(:page => params[:page], :per_page => 4).order('created_at DESC')    
      # @active_feeds = 1
      @search_in = "FEEDS"
      @active_photo_tag = 1
      render 'search'
    else 
      self.feeds_photos
    end
  end
  
  def feeds_photos
    followers_ids = current_user.followers.ids
    @photos = Photo.includes(:user).public_mode.where(user_id: followers_ids).paginate(:page => params[:page], :per_page => 4).order('created_at DESC')
    @active_feeds = 1
    @active_photo_tag = 1
    render 'index'
  end

  def feeds_albums
    followers_ids = current_user.followers.ids
    @albums = Album.includes(:user).public_mode.where(user_id: followers_ids).paginate(:page => params[:page], :per_page => 4).order('created_at DESC')    
    @active_feeds = 1
    @active_album_tag = 1
    render 'index'
  end

  def discover
    if params[:search].present? #SEARCH
      @search = params[:search].strip
      if current_user
        @photos = Photo.includes(:user).public_mode.where.not(user_id: current_user).where("title LIKE ?", "%#{@search}%").public_mode.paginate(:page => params[:page], :per_page => 4).order('created_at DESC')
        @albums = Album.includes(:user).public_mode.where.not(user_id: current_user).where("title LIKE ?", "%#{@search}%").public_mode.paginate(:page => params[:page], :per_page => 4).order('created_at DESC')
      else
        @photos = Photo.where("title LIKE ?", "%#{@search}%").public_mode.paginate(:page => params[:page], :per_page => 4).order('created_at DESC')
        @albums = Album.where("title LIKE ?", "%#{@search}%").public_mode.paginate(:page => params[:page], :per_page => 4).order('created_at DESC')      
      end
      # @active_discover = 1      
      @active_photo_tag = 1
      @search_in = "DISCOVER"
      render 'search'
    else 
      self.discover_photos
    end
  end

  def discover_photos
    if current_user
      @photos = Photo.includes(:user).public_mode.where.not(user_id: current_user).paginate(:page => params[:page], :per_page => 4).order('created_at DESC')
    else
      @photos = Photo.public_mode.paginate(:page => params[:page], :per_page => 4).order('created_at DESC')
    end 
    @active_discover = 1
    @active_photo_tag = 1
    render 'index'
  end

  def discover_albums
    if current_user
      @albums = Album.includes(:user).public_mode.where.not(user_id: current_user).paginate(:page => params[:page], :per_page => 4).order('created_at DESC')    
    else
      @albums = Album.public_mode.paginate(:page => params[:page], :per_page => 4).order('created_at DESC')
    end
    @active_discover = 1
    @active_album_tag = 1
    render 'index'
  end
end
