class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.all.order(created_at: :desc)
  end

  def edit
  end
end
