class Group < ApplicationRecord

  has_many :group_users, dependent: :destroy
  belongs_to :owner, class_name: "User"
  has_many :users, through: :group_users, source: :user
  has_many :approved_users, -> { where(group_users: { is_participation: true }) }, through: :group_users, source: :user

  validates :name, presence: true
  has_one_attached :group_image

  def get_group_image
    (group_image.attached?) ? group_image : 'no_image.jpg'
  end

  def is_owned_by?(user)
    owner.id == user.id
  end

  def include_user?(user)
    group_users.exists?(user_id: user.id)
  end

  def self.search_by_owner_name(word)
    joins(:owner).where("users.last_name LIKE ? OR users.first_name LIKE ?", "%#{word}%", "%#{word}%")
  end

  def self.search_by_member_name(word)
    joins(:users).where("users.last_name LIKE ? OR users.first_name LIKE ?", "%#{word}%", "%#{word}%").distinct
  end

end
