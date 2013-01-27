class EntriesController < ApplicationController
  
  before_filter :get_entry, only: [:show, :edit, :update, :destroy]
  
  def index
    @entries = OPortfolioApi.get_entries(session[:user_credentials])
  end
  
  def show
  end
  
  def new
    @entry = {occurred_at: Date.today}
  end
  
  def create
    fix_date_format
    if @entry = OPortfolioApi.create_entry(session[:user_credentials], params)
      redirect_to entry_path(@entry[:id]), notice: "Entry created"
    else
      flash.now[:error] = "There were errors saving this entry. Have you written a title?"
      @entry = params
      render "new"
    end
  end
  
  def edit
  end
  
  def update
    fix_date_format
    if OPortfolioApi.update_entry(session[:user_credentials], params[:id], params)
      redirect_to entry_path(@entry[:id]), notice: "Entry updated"
    else
      flash.now[:error] = "There were errors saving this entry. Have you written a title?"
      render "edit"
    end
  end
  
  protected
  
    def get_entry
      @entry = OPortfolioApi.get_entry(session[:user_credentials], params[:id])
    end
    
    def fix_date_format
      params[:occurred_at] = Date.new(params[:occurred_at][:year].to_i, params[:occurred_at][:month].to_i, params[:occurred_at][:day].to_i)
    end
  
end