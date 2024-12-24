class Post < ApplicationRecord

  validates :task_id, presence: true
  validates :time_taken, presence: true, on: :update
  validates :start, presence: true
  validates :end, presence: true
  

  belongs_to :user
  belongs_to :task
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user


  def self.looks(word)
    joins(:task).where("tasks.name LIKE ?", "%#{word}%")
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
