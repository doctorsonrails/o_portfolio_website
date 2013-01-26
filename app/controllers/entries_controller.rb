class EntriesController < ApplicationController
  
  def index
    render json: [{title: "iHiD"}, {title: "nottrobin"}]
  end
  
end