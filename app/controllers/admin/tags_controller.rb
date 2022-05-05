class Admin::TagsController < ApplicationController
  def index
    @tags = Tag.all.order(:name).page(params[:page]).per(20)
  end
  
  
  
  
  def destroy
    Tag.find(params[:id]).destroy
    flash[:notice] = "タグを削除しました。"
    redirect_to admin_tags_path
  end
end