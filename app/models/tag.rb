class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: "tag_id"
  has_many :posts, through: :post_tags

  validates :name, uniqueness: true, presence: true
  
  #検索
  def self.looks(word)
    @tag = Tag.where("name LIKE?","#{word}")
  end

end
