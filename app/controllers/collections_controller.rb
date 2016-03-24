class CollectionsController < ApplicationController
  before_action :logged_in_user
  
  def create
    micropost = Micropost.find(params[:collected_id])
    current_user.collect(micropost)
    flash[:success] = "Collected Successfully!"
    redirect_to micropost
  end

  def destroy
    micropost = Collection.find(params[:id]).collected
    current_user.uncollect(micropost)
    flash[:success] = "Unfavorited Successfully!"
    redirect_to micropost
  end
end
