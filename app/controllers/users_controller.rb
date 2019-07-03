class UsersController < ApplicationController
  # layout "s_layout"
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def edit
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
