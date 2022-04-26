class Admin::PostsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @customer = Customer.find(params[:customer_id])
    @posts = @customer.posts.page(params[:page]).per(10)
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @customer = @post.customer
    @post_tags = @post.tags
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to admin_customer_posts_path(@post.customer)
  end
end
