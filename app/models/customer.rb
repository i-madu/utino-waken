class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :name,length: { in: 1..20 }
  validates :login_name, length: { in: 1..20 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_one_attached :profile_image
  #フォローした/一覧
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  #フォローされた/一覧
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  #フォローした時
  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end

  #フォローを外す時
  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
  end

  #フォローしているか判定
  def followings?(customer)
    followings.include?(customer)
  end



  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [width, height]).processed
  end


  def self.guest
    find_or_create_by!(name:"guestcustomer",email:"guest@example.com", login_name: "") do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "guestcustomer"
    end
  end


  def active_for_authentication?
    super && (is_deleted == false)
  end

  #検索
  def self.search(search)
    Customer.where("login_name LIKE ?","%#{search}%") if search != ""
  end

end
