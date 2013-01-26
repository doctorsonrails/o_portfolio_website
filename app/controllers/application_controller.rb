class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :check_logged_in
  
  protected
    def check_logged_in
      redirect_to new_session_path and return false unless logged_in? 
      true
    end
    
    def logged_in?
      !!session[:user]
    end
    
    def current_user
      session[:user]
    end
end
