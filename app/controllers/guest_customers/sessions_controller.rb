class GuestCustomers::SessionsController < Devise::SessionsController
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to posts_path, notice:"ゲストログインしました。"
  end
end