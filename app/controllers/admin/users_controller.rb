class Admin::UsersController < ApplicationController
  before_filter :admin?

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
      # session[:user_id] = @user.id
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

  def become_user
    session[:admin_user_id] = current_user.id
    session[:user_id] = params[:id]
    @temp_user_name = User.find(params[:id]).full_name
    redirect_to root_url
    flash[:alert] = "Temporarily logged in as #{@temp_user_name}"
  end

  protected

  def admin_user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end


end
