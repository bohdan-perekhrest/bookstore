# frozen_string_literal: true

module Users
  module Settings
    class PrivacyController < ApplicationController
      before_action :authenticate_user!, :set_user

      def index; end

      def update
        if params[:user][:update_email]
          @user.skip_password_validation = true
          redirect_to_if(@user.update_without_password(email_params), 'Email')
        elsif params[:user][:update_password]
          redirect_to_if(@user.update_with_password(password_params), 'Password')
        end
      end

      private

      def redirect_to_if(condition, type)
        if condition
          bypass_sign_in @user, scope: :user
          redirect_to privacy_path, notice: I18n.t('user.updated')
        else
          redirect_to privacy_path, alert: "#{type} is invalid"
        end
      end

      def email_params
        params.require(:user).permit(:email)
      end

      def password_params
        params.require(:user).permit(:current_password, :password, :password_confirmation)
      end

      def set_user
        @user = current_user
      end
    end
  end
end
