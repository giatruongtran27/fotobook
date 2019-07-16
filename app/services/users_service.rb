module UsersService
  class << self
    def list_photos(current_user, user)
      if full_authorities_for_this_user? current_user, user
        user.photos
      else
        user.photos.public_mode
      end
    end

    def list_albums(current_user, user)
      if full_authorities_for_this_user? current_user, user
        user.albums
      else
        user.albums.public_mode
      end
    end

    def full_authorities_for_this_user?(current_user, user)
      current_user and (current_user.id.equal? user.id or current_user.admin?)
    end
  end
end