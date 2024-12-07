class Task < ApplicationRecord
  validates :name, presence: true
  validates :explanation, presence: true
  validates :average_time, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  has_many :posts

  def calculate_average_time
    # 条件に合致する投稿のみを対象とする
    completed_posts = posts.where(is_completion: true)
    # 平均を計算して整数化、存在しない場合はnilを返す
    completed_posts.exists? ? completed_posts.average(:time_taken).to_i : nil
  end

end
