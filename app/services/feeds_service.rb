module FeedsService
  class << self
    def feeds(relation, followers_ids, page_params, search = "")
      relation
        .includes(:user)
        .includes(:likes)
        .where("title LIKE ?", "%#{search}%")
        .public_mode
        .where(user_id: followers_ids)
        .paginate(:page => page_params, :per_page => 4)
        .order("created_at DESC")
    end

    def discover(relation, current_user, page_params, search = "")
      if current_user.nil?
        discover_all(relation, page_params, search)
      else
        discover_for_logined_user(relation, current_user, page_params, search)
      end
    end
    
    private
      def discover_for_logined_user(relation, current_user, page_params, search = "")
        relation
        .includes(:user)
        .public_mode
        .where.not(user_id: current_user)
        .where("title LIKE ?", "%#{search}%")
        .public_mode
        .paginate(:page => page_params, :per_page => 4)
        .order('created_at DESC')
      end

      def discover_all(relation, page_params, search = "")
        relation
        .includes(:user)
        .public_mode
        .where("title LIKE ?", "%#{search}%")
        .public_mode
        .paginate(:page => page_params, :per_page => 4)
        .order('created_at DESC')
      end
  end
end