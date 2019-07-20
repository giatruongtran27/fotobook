module FeedsHelper
  def search_feeds? active_page
    active_page and active_page.eql? "feeds"
  end
end
