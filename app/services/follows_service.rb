module FollowsService
  class << self
  
    def call(current_user, follower)
      if current_user.followers.include? follower # case unfollow
        current_user.followers.delete(follower)
        :unfollow
      else                                         # case follow
        current_user.followers << follower
        :follow
      end
    end

    def at_follower_profile?(follower, user)
      follower.eql? user
    end

    def at_your_profile?(current_user, user)
      current_user.eql? user
    end

  end
end