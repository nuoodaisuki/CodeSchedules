class GroupUser < ApplicationRecord

  belongs_to :user
  belongs_to :group

  def approved?
    is_participation
  end

  after_destroy :destroy_user_messages

  private

  def destroy_user_messages
    group.group_messages.where(user_id: user_id).destroy_all
  end

end
