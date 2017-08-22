# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  include Notificable
  belongs_to :user
  scope :nuevos, ->{ order("created_at desc")}
  after_create :send_to_action_cable
=begin
  1.- Mis propias publicaciones
  2.- Las de mis amigos
    * user_id => amistad.friend_id
    * user_id => user.friend_id
    * Amistad fue aceptada
=end
  def self.all_for_user(user)
    Post.where(user_id: user.id).or(Post.where(user_id: user.friend_ids)).or(Post.where(user_id: user.user_ids))
  end
  
  def user_ids
    self.user.friend_ids + self.user.user_ids
  end
  
  private 
    def send_to_action_cable
      data = {message: to_html,action: "new_post"}
      self.user.friend_ids.each do |friend_id|
        ActionCable.server.broadcast "post_#{friend_id}", data
      end
      
      self.user.user_ids.each do |friend_id|
        ActionCable.server.broadcast "post_#{friend_id}", data
      end
    end
    
    def to_html
      ApplicationController.renderer.render(partial: "posts/post",locals: { post: self })
    end
  
end
