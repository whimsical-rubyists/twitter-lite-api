class UserMailer < ApplicationMailer
  default :from => "noreply@twitterlite.com"

  def registration_confirmation(user)
    @user = user
    @token = user.confirm
    mail(:to => "#{@user.username}" "<#{@user.email}>", :subject => "Please confirm your registration.")
  end
end
