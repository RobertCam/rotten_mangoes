class UserMailer < ActionMailer::Base
  default from: "from@example.com"


  def created_account(user)
    @user = user
    # @url = 'example@rottenmangoes.com/login'
    mail(to: @user.email, subject: 'Welcome to Rotten Mangoes!')
  end

  def deleted_account(user)
    @user = user
    # @url = 'example@rottenmangoes.com/delete'
    mail(to: @user.email, subject: 'Your Rotten Mangoes account has been deleted. Sorry to see you go!')
  end
end
