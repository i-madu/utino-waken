class Public::SearchsController < ApplicationController
  before_action :authenticate_customer!
  
  def search
    @search = params[:search]
    if @search == "ログイン名"
      @customers = Customer.looks(params[:search]), params[:word]
    else
      @tags = Tag.looks(params[:search]), params[:word]
    end
  end
  
  
end
