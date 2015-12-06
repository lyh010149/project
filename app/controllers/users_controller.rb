class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
  end

  def new
  	@user = User.new
  end

  def create
  	secure_params = params.require(:user).permit(:name, :email, 
                                  :password, :password_confirmation)
    @user = User.new(secure_params)
    if @user.save
      remember @user
      flash[:success] = "Welcome to the Twitter App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
end
