class FeedsController < ApplicationController
  before_action :authenticate_user!, only: [:feeds]
  def feeds
    puts current_user
    render 'index'
  end

  def discover
    render 'index'
  end
end
