class Admin::CommentsController < ApplicationController
  before_action :authenticate_customer!
  def destroy
    @post = Post.find(params[:post_id])
    Comment.find_by(params[:id]).destroy
  end
end
