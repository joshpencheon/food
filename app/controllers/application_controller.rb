class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :simulate_xhr
  
  private
  
  def simulate_xhr
    sleep(1) if request.xhr? && request.post? && Rails.env.development?
  end
end
