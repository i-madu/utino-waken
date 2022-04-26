class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def destroy
    @post = Post.find(params[:post_id])
    Comment.find(params[:id]).destroy
  end
end
