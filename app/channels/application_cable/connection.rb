# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    
    def connect
      self.current_user = find_user
    end
    
    def find_user
      user_id = cookies.signed["user.id"]
      current_user = User.find_by(id: user_id)
      if current_user
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end