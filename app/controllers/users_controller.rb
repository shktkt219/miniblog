class UsersController < ApplicationController
  before_action :user_signed_in?, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
  end

  def show
    @user = User.find(params[:id])
    # it even works through the posts association, reaching into the posts table and pulling out the desired page of posts.
    @posts = @user.posts.paginate(page: params[:page])
    @post = Post.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
   User.find(params[:id]).destroy
   flash[:success] = "User deleted"
   redirect_to users_url
 end

 def following
   @title = "Following"
   @user = User.find(params[:id])
   @users = @user.following.paginate(page: params[:page])
   render 'show_follow'
 end

 def followers
   @title = "Followers"
   @user = User.find(params[:id])
   @users = @user.followers.paginate(page: params[:page])
   render 'show_follow'
 end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    #confirm the correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    #confirm an admin user
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
