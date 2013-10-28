class UserMailer < ActionMailer::Base
  default from: "slakat@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://showganizer-www.herokuapp.com/login'
    mail(to: @user.email, subject: 'Welcome to the Awesome showganizer')
  end

    def new_episode(user)
    @user = user
    @url  = 'http://showganizer-www.herokuapp.com/me/series'
    mail(to: @user.email, subject: 'New Episode')
  end

end
