class ApplicationController < ActionController::Base
  protect_from_forgery

  def welcome
    render 'welcome'
  end
  
end
