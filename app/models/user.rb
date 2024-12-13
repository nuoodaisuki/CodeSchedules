class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :last_name, :first_name, presence: true

  has_one_attached :image
  has_many :posts, dependent: :destroy


  def name
    "#{last_name} #{first_name}"
  end

  def self.looks(word)
    where("introduction LIKE ?", "%#{word}%")
  end

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.last_name = "guest"
      user.first_name = "user"
    end
  end
  
end
