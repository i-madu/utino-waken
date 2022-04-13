class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :direct_type, only: [:edit]

  def index
    @customer = current_customer
    @posts = Post.all.order(created_at: :desc)
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @customer = @post.customer
    @comment = Comment.new
    @post_tags = @post.tags
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    tag_list = params[:post][:name].split(nil)
    if @post.save
      @post.save_tag(tag_list)
      flash[:notice] = "新規投稿が完了しました！"
      redirect_to posts_path
    else
      flash.now[:alert] = "投稿内容が空欄のままか、文字数を超過しました。"
      render "new"
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:name].split(nil)
    if @post.update(post_params)
      @post.save_tag(tag_list)
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
