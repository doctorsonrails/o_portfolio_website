class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :check_logged_in
  
  helper_method :current_user, :logged_in?
  
  protected
    def check_logged_in
      redirect_to new_session_path and return false unless logged_in? 
      true
    end
    
    def logged_in?
      !!session[:user_credentials]
    end
    
    def current_user
      session[:user_credentials]
    end
    
    def save_session(username, password, user_id)
      session[:user_credentials] = {username: username, password: password}
      session[:user_id] = user_id
    end
end
