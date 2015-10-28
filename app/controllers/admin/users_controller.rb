class Admin::UsersController < ApplicationController
  before_filter :admin?

  def admin?
    return if session[:admin_user_id]
    unless current_user && current_user.admin
      redirect_to movies_path
    end
  end

  def index
    if session[:admin_user_id]
      session[:user_id] = session[:admin_user_id]
      session[:admin_user_id] = nil
    end
    @admin = User.find(session[:user_id])
  end

  def show
    @user = User.find(params[:id])
  end

   def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    @user.save
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(post_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def create
  end

  def destroy
    @user = User.find(params[:id])
    flash.now[:alert] = "Successfully Deleted #{@user.full_name}"

    @user.destroy
    redirect_to admin_users_path

  end


  def become_user
    session[:admin_user_id] = current_user.id
    session[:user_id] = params[:id]
    @temp_user_name = User.find(params[:id]).full_name
    redirect_to root_url
    flash[:alert] = "Temporarily logged in as #{@temp_user_name}"
  end

  protected

  def post_params
    params.require(:user).permit(:email, :firstname, :lastname, :admin)
  end


end
