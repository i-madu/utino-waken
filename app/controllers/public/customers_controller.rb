class Public::CustomersController < ApplicationController
  before_action :direct_type, only: [:edit, :unsubscribe]
  before_action :authenticate_customer!

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.all.order(created_at: :desc).page(params[:page]).per(10)
    @tag_list = Tag.all
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "プロフィールを更新しました。"
      redirect_to customer_path(@customer)
    else
      flash.now[:alert] = "フォームへ情報を入力してください。"
      render "edit"
    end
  end

  def unsubscribe
    @customer = Customer.find(params[:id])
  end

  def withdrawal
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました。またのご利用お待ちしております。"
    redirect_to root_path
  end

  def search
    redirect_to request.referer if params[:keyword] == ""
    # split_keywords = params[:keyword].split(/[[:blank:]]+/)
    # @customers = Customer.where("login_name like ?","%#{keyword}%")
    @customers = Customer.search(params[:keyword])
    @tag_list = Tag.all
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :login_name, :introduction, :profile_image)
  end

  def direct_type
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to posts_path
    end
  end

end
