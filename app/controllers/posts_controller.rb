class PostsController < ApplicationController
  before_action :user_signed_in?, only: [:index, :new, :create, :show, :destroy]
  before_action :correct_user, only: :destroy

  def index
    if params[:user_id] != nil
      @user = User.find(params[:user_id])
      @posts = @user.posts
    else
      @posts = Post.all
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'posts/new'
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(post_id: @post)
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post deleted"
    #just the previous URL
    redirect_to request.referrer || root_url
  end

  private

    def post_params
      params.require(:post).permit(:content, :user_id, tag_ids:[], tags_attributes: [:name])
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
