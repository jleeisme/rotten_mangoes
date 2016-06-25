class Admin::UsersController < ApplicationController
  # before_action :require_admin
  def index
    @users = User.all  
  end

def destroy
    @user = User.find(params[:id])
    flash[:success] = "User deleted"
    if @user.destroy
      #binding.pry
      #UserNotifier.user_delete(@user).deliver
      redirect_to movies_path
    end
  end

end
