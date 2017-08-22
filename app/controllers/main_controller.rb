class MainController < ApplicationController
  def home
    @post = Post.new
    @posts = Post.all_for_user(current_user).nuevos.paginate(page:params[:page],per_page:15)
    respond_to do |format| 
      format.html
      format.js
    end
  end
  def unregistered
  end
  
  protected
    def set_layout
      return "landing" if action_name == "unregistered"
      super
    end
end
