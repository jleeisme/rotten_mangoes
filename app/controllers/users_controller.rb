class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      render :new
    end
  end

# destroy the user with the ass't id and then redirect.
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    if @user.destroy
      UserNotifier.user_delete(@user).deliver
      redirect_to movies_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end

end