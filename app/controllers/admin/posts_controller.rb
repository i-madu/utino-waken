class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @customer = @post.customer
    @post_tags = @post.tags
  end

  def destroy
  end

end
