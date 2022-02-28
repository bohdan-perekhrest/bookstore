# frozen_string_literal: true

class Users::RegistrationController < Devise::RegistrationsController
  def create
    super
    #UserMailer.confirm_account(*sending_params).deliver_later if current_user
  end
end
