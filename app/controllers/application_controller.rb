class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #Must include session helper to enable to login and logout
  include SessionsHelper
end
