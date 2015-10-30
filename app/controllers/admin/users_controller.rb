class Admin::UsersController < ApplicationController
  before_filter :admin?, except: [:return_to_admin]

  def admin?
    unless current_user && current_user.admin
      redirect_to movies_path
    end
  end

  def index
    if current_user.admin
      @admin = User.find(session[:user_id])
      @users = User.order("id").page(params[:page]).per(10)
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
   @user = User.new(admin_user_params) 
    if @user.save
      redirect_to movies_path, notice: "User created, #{@user.firstname}!"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(admin_user_params)
      redirect_to admin_user_path(@user), notice: "User updated"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: 'User deleted!'
  end

  def switch_to_user
    session[:admin_user_id] = current_user.id 
    session[:user_id] = params[:id]
    redirect_to movies_path, notice: "Temporarily logged in as #{current_user.firstname}"
  end

  def return_to_admin
    current_user_reset
    session[:user_id] = session[:admin_user_id]
    session[:admin_user_id] = nil
    redirect_to admin_users_path
  end

  protected

  def admin_user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end


end
