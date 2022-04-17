class Public::RelationshipsController < ApplicationController

  #フォローした時
  def create
    follow = current_customer.follow(params[:customer_id])
    @customer = Customer.find(follow.followed_id)
  end

  #フォローを外す時
  def destroy
    follow = current_customer.unfollow(params[:customer_id]).destroy
    @customer = Customer.find(follow.followed_id)
  end

  def followings
    @customer = Customer.find(params[:customer_id])
    @customers = @customer.followings
  end

  def followers
    @customer = Customer.find(params[:customer_id])
    @customers = @customer.followers
  end

end
