class My::ProfilesController < ApplicationController
  before_filter :logged_in

  def edit 
    @user = current_user
  end

  def show
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to edit_my_profile_path(@user), notice: "User updated"
    else
      render :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname)
  end

  def logged_in
    redirect_to root_path, notice: "You must be logged in!" unless current_user
  end
end
