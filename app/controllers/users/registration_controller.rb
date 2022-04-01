# frozen_string_literal: true

module Users
  class RegistrationController < Devise::RegistrationsController
    def create
      super
      flash[:alert] = I18n.t('user.not_sign')
      UserMailer.welcome_email(*sending_params).deliver_later
    end

    private

    def sending_params
      [params[:user][:email], params[:user][:password]]
    end
  end
end
