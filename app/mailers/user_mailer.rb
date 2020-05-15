# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: "noreply@twitterlite.com"

  def registration_confirmation(user, token)
    @user = user
    @token = token
    mail(to: "#{@user.username}" "<#{@user.email}>", subject: "Please confirm your registration.")
  end
end
