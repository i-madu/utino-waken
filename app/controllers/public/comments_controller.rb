class Public::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = current_customer.comments.new(comment_params)
    comment.post_id = @post.id
    if  comment.save
      flash[:notice] = "コメントを投稿しました。"
    else
      flash.now[:alert] = "フォーム内容が空白のままコメントを投稿することはできません。"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find_by(params[:id]).destroy
  end


  private

  def comment_params
    params.require(:comment).permit(:comment)
  end


end
