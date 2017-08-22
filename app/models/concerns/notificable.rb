module Notificable
  extend ActiveSupport::Concern
  
  included do
    has_many :notifications, as: :item
    after_commit :send_notification_to_users
  end
  
  def send_notification_to_users
    if self.respond_to? :user_ids
      #JOB => mandar notificaciones async
      NotificationSenderJob.perform_later(self)
    end
  end
end