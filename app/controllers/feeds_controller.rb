class FeedsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new]
  def index
    render 'index.html.erb'
  end
end
