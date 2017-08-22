module NotificationsHelper
  def render_notifications(notifications)
    notifications.map do |notification|
      render partial:"notifications/#{notification.item_type.downcase}", locals:{notification: notification}
    end.join(" | ").html_safe
  end
end
