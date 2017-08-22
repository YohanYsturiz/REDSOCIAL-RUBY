class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(user:current_user).unviewed.latest
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def update
    @notification = Notification.find(params[:id])
    message = if @notification.update(notification_params)
      "Notification vista"
    else
      "Hubo un error"
    end
    redirect_to :back, notice: message
  end
  
  private
    def notification_params
      params.require(:notification).permit(:viewed)
    end
end
