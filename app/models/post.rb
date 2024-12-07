class Post < ApplicationRecord

  validates :time_taken, presence: true, on: :update

  belongs_to :user
  belongs_to :task

end
