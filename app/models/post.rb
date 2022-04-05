class Post < ApplicationRecord
  belongs_to :customer
  
  has_many :favorites, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  
end
