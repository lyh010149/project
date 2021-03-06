class MicropostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy, :index]
  
  def index
    @micropost  = current_user.microposts.build
    if params[:search]
      @microposts = current_user.feed.search(params[:search]).order("created_at DESC")
    else
      @microposts = Micropost.order("created_at DESC")
    end
  end
  
  def show
    @micropost = Micropost.find(params[:id])
  end

  def create
    	secure_post = params.require(:micropost).permit(:name, :content, :picture)
      @micropost = current_user.microposts.build(secure_post) 
      if @micropost.save
        flash[:success] = "Recipe created!"
        redirect_to root_url
      else
          @feed_items = []
          render 'static_pages/home'
      end
  end
    	
	def destroy
    @micropost=Micropost.find(params[:id])
    @micropost.destroy
    redirect_to root_url
  end

  # NEW PRIVATE METHOD
  private
    def micropost_params
      params.require(:micropost).permit(:name, :content, :picture)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
