class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!,except:[:index]
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    flash[:notice] = "会員情報を変更しました。"
    redirect_to admin_customer_path(@customer)
  end

  def search
    redirect_to request.referer if params[:keyword] == ""
    @customers = Customer.search(params[:keyword])
    @tag_list = Tag.all
  end


  private
  def customer_params
    params.require(:customer).permit(:email, :name, :login_name, :is_deleted, :introduction, :withdraw )
  end

end
