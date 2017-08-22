class PostChannel < ApplicationCable::Channel
  def subscribed
    stream_from "post_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
