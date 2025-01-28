class GroupUser < ApplicationRecord

  belongs_to :user
  belongs_to :group
  has_many :notifications, as: :notifiable, dependent: :destroy


  def approved?
    is_participation
  end

  after_destroy :destroy_user_messages

  after_create :notify_group_owner
  after_update :notify_user_on_approval

  private

  def destroy_user_messages
    group.group_messages.where(user_id: user_id).destroy_all
  end

  # グループオーナーに通知を送る
  def notify_group_owner
    Notification.create!(
      user: group.owner, # 仮にGroupモデルにownerが定義されているとします
      notifiable: self,
      read: false
    )
  end

  # ユーザーに承認通知を送る
  def notify_user_on_approval
    return unless is_participation

    Notification.create!(
      user: user,
      notifiable: self,
      read: false
    )
  end
end
