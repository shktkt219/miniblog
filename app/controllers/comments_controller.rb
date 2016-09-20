class CommentsController < ApplicationController
  before_action :user_signed_in?
  before_action :find_post, only: [:create, :destroy, :edit, :update]
  before_action :find_comment, only: [:destroy, :edit, :update]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "commented"
      redirect_to user_post_path(@post.user, @post)
    else
      render 'comments/new'
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "Comment deleted"
    redirect_to user_post_path(@post.user, @post)
  end

  def edit

  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "your comment updated"
      redirect_to user_post_path(@post.user, @post)
    else
      render 'comments/edit'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end
end
