class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #Must include session helper to enable to login and logout
  include SessionsHelper

  #To avoid user seeing cache page, it responses that there will not be any cache and should not be stored.
  before_action :set_as_private
  before_action :check_page

  def set_as_private
  	response.headers['Cache-Control'] = 'no-cache, no-store'
  end

  #Check if the user has already login and try to go to login, then redirect to course index
  def check_page
  	if request.path == "/login" && logged_in?
  		redirect_to courses_index_url
  	end
  end

  def routing_error
    render file: "#{Rails.root}/public/404.html", status: 404
  end

end
