class SessionController < ApplicationController
  
  skip_before_filter :check_logged_in
  
  def new
  end
  
  def login
    if user = OPortfolioApi.authenticate(username: params[:email], password: params[:password])
      save_session(params[:email], params[:password], user[:id])
      redirect_to entries_path
    else
      flash.now[:error] = "Incorrect Email or Password"
      render "new"
    end
  end
  
  def logout
    reset_session
    redirect_to root_path
  end
end