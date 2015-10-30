class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def index
    @users = User.order("id").page(params[:page]).per(10)
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # send email to user upon account creation
        puts UserMailer.created_account(@user).deliver_later
        redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
        session[:user_id] = @user.id
      else
        render :new
      end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end

end 

