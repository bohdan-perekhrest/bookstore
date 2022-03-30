# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'bohdan.perekhrest@bookstore.com'

  def welcome_email(email, password)
    @email = email
    @password = password
    @url = new_user_session_url
    mail(to: @email, subject: t('mailer.subject'))
  end
end
