class GroupUser < ApplicationRecord

  belongs_to :user
  belongs_to :group

  def approved?
    is_participation
  end

end
