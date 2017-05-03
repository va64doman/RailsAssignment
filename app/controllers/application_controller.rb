class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #Must include session helper to enable to login and logout
  include SessionsHelper

  #To avoid user seeing cache page, it responses that there will not be any cache and should not be stored.
  before_action :set_as_private

  def set_as_private
  	response.headers['Cache-Control'] = 'no-cache, no-store'
  end
end
