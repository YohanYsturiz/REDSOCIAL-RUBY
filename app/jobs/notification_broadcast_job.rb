class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notification)
    notification_count = Notification.for_user(notification.user_id)
    ActionCable.server.broadcast "notifications.#{notification.user_id}", {action: "new_notification", message:notification_count}
  end
end
