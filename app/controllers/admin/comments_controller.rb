class Admin::CommentsController < ApplicationController
  def destroy
    @post = Post.find(params[:post_id])
    Comment.find_by(params[:id]).destroy
  end
end
