class PostsController < ApplicationController
  before_action :user_signed_in?, only: [:new, :create, :destroy]
  before_action :correct_user, only: :destroy

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
