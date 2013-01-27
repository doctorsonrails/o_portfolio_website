class UsersController < ApplicationController
  
  skip_before_filter :check_logged_in, only: [:create]
  
  def create
    if user = OPortfolioApi.create_user(params)
      save_session(params[:email], params[:password], user[:id])
      redirect_to new_entry_path, notice: "Account Created"
    else
      flash.now[:error] = "There were errors creating this user. Have you previously signed up?"
      render "new"
    end
  end
  
  def edit
    @user = OPortfolioApi.get_user(session[:user_credentials], session[:user_id])
  end
  
  def update
    @user = OPortfolioApi.update_user(session[:user_credentials], session[:user_id], params)
    redirect_to edit_user_path, notice: "Settings Saved"
  end
  
end