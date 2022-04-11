class Post < ApplicationRecord
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :comments, dependent: :destroy
  has_one_attached :post_image

  validates :post, presence: true, length: { maximum: 300 }
  

  #いいね機能
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  def save_tag(sent_tags)
    #タグが存在しているか確認し、存在していたらタグの名前を全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags #送られてきたタグから現在テーブルにあるタグを除く
    
    #古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end
    
    #新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end



end
