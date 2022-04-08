class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :direct_type, only: [:edit]

  def index
    @customer = current_customer
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      flash[:notice] = "新規投稿が完了しました！"
      redirect_to posts_path
    else
      flash.now[:alert] = "投稿内容を入力してください。"
      render "new"
    end
  end

  def edit
    
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿の更新が完了しました！"
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "更新内容が空のままです。"
      render "new"
    end
  end

  def destroy
  end


  def direct_type
    @post = Post.find(params[:id])
    unless @post.customer_id == current_customer.id
      redirect_to posts_path
    end
  end



  private

  def post_params
    params.require(:post).permit(:post,:post_image)
  end


end
