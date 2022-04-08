class Public::CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(comment_params)
    comment.customer_id = current_customer
    if  comment.save
      flash[:notice] = "コメントを投稿しました。"
      redirect_to request.referer
    else
      flash.now[:alert] = "フォーム内容が空白のままコメントを投稿することはできません。"
      render request.referer
    end
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to request.referer
  end
    
  
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
  
  
end
