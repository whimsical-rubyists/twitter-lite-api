class UserMailer < ActionMailer::Base
  default :from => "noreply@twitterlite.com"
  
  def account_confirmation(user)
    @user = user
    mail(:to => "#{user.username} <#{user.email}>",
    :subject => "Please confirm your account regiatration")
  end
end
