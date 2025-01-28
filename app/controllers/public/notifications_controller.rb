class Public::NotificationsController < Public::ApplicationController
  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    redirect_to group_path(notification.notifiable.group)
  end
end
