class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!, except: [:welcome]

  def welcome
  	if current_user
      render 'home'
    else
      render 'welcome'
    end
  end
  
end
