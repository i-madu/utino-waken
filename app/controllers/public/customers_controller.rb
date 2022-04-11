class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.all.order(created_at: :desc)
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

  private

  def customer_params
    params.require(:customer).permit(:name, :login_name, :introduction, :profile_image)
  end

end
