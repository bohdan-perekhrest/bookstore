# frozen_string_literal: true

module Users
  module Settings
    class PrivacyController < ApplicationController
      before_action :authenticate_user!
      load_and_authorize_resource :user

      def index; end

      def update
        if params[:user][:update_email]
          @user.skip_password_validation = true
          redirect_to_if(@user.update_without_password(email_params))
        elsif params[:user][:update_password]
          redirect_to_if(@user.update_with_password(password_params))
        end
      end

      private

      def redirect_to_if(condition)
        if condition
          bypass_sign_in @user, scope: :user
          redirect_to privacy_path, notice: I18n.t('user.updated')
        else
          redirect_to privacy_path, alert: I18n.t('user.not_updated')
        end
      end

      def email_params
        params.require(:user).permit(:email)
      end

      def password_params
        params.require(:user).permit(:current_password, :password, :password_confirmation)
      end
    end
  end
end