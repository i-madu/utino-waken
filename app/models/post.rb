class Post < ApplicationRecord
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_one_attached :post_image
  
  validates :post, presence: true, length: { maximum: 200 }
  
  #いいね機能
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
  
  
  
end
