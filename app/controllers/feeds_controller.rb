class FeedsController < ApplicationController
  before_action :authenticate_user!, :set_followers_ids, :set_active_feeds, only: [:feeds, :feeds_photos, :feeds_albums]
  before_action :set_active_discover, only: [:discover, :discover_photos, :discover_albums]

  def feeds
    if params[:search].present? #SEARCH
      @search = params[:search].strip
      @photos = FeedsService.feeds(Photo ,@followers_ids, params[:photo_page], @search)
      @albums = FeedsService.feeds(Album ,@followers_ids, params[:album_page], @search) 
      @search_in = t('title.feeds')
      @active_page = "feeds_search"
      render "search"
    else 
      self.feeds_photos
    end
  end
  
  def feeds_photos
    @photos = FeedsService.feeds(Photo ,@followers_ids, params[:photo_page])
    params[:active_tab] = "photos"
    render "index"
  end

  def feeds_albums
    @albums = FeedsService.feeds(Album ,@followers_ids, params[:album_page])
    params[:active_tab] = "albums"
    render "index"
  end

  def discover
    if params[:search].present? #SEARCH
      @search = params[:search].strip
      @photos = FeedsService.discover(Photo, current_user, params[:photo_page], @search)
      @albums = FeedsService.discover(Album, current_user, params[:album_page], @search)
      @search_in = t('title.discover')
      @active_page = "discover_search"
      render "search"
    else 
      self.discover_photos
    end
  end

  def discover_photos
    @photos = FeedsService.discover(Photo, current_user, params[:photo_page])
    params[:active_tab] = "photos"
    render "index"
  end

  def discover_albums
    @albums = FeedsService.discover(Album, current_user, params[:album_page])
    params[:active_tab] = "albums"
    render "index"
  end

  private
    def set_followers_ids
      @followers_ids = current_user.followers.ids
    end

    def set_active_feeds
      @active_page = "feeds"
    end

    def set_active_discover
      @active_page = "discover"
    end
end