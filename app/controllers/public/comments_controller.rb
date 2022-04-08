class Public::CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = current_customer.comments.new(comment_params)
    comment.post_id = post.id
    if  comment.save
      flash[:notice] = "コメントを投稿しました。"
      redirect_to request.referer
    else
      flash.now[:alert] = "フォーム内容が空白のままコメントを投稿することはできません。"
      redirect_to request.referer
    end
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to request.referer
  end



  private

  def comment_params
    params.require(:comment).permit(:comment)
  end


end
