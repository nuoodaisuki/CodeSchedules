module Public::NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "GroupUser"
      if notification.notifiable.is_participation
        "#{notification.notifiable.group.name} への参加が承認されました。"
      else
        "#{notification.notifiable.user.name} さんが #{notification.notifiable.group.name} に参加リクエストを送ってきました。"
      end
    else
      "不明な通知です。"
    end
  end
end