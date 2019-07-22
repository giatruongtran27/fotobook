class ErrorsController < ApplicationController
  def not_found
    render :file => "#{Rails.root}/public/404.html",  :status => 404, layout: 'errors_layout'
  end

  def unprocessable_entity
    render :file => "#{Rails.root}/public/422.html",  :status => 422, layout: 'errors_layout'
  end

  def internal_server_error
    render :file => "#{Rails.root}/public/500.html",  :status => 500, layout: 'errors_layout'
  end
end
