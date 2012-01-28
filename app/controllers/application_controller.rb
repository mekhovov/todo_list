class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!, except: [:welcome]

  def welcome
  	if current_user
      redirect_to :projects
    else
      render 'welcome'
    end
  end
  
end
