class Admin::PostsController < ApplicationController
  def index
    @customer = Customer.find(params[:customer_id])
    @posts = @customer.posts
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
