# frozen_string_literal: true

class Api::V1::UserController < ApplicationController
  skip_before_action :authorize_request, only: :login

  def login
    authenticator = Auth::Authentication.new(auth_params[:email], auth_params[:password])

    unless authenticator.authenticable?
      head :unauthorized
      return
    end

    unless authenticator.authenticated_user.actived?
      return render json: { message: I18n.t("message_response.account_inactived") }, status: :unauthorized
    end

    render json: authenticator.authenticated_user, serializer: Api::V1::User::LoginSerializer
  end

  def logout
    head :ok
  end

  def ping_role
    render json: { role: @current_user.role }
  end

  def profile
    render json: @current_user, each_serializer: Api::V1::UserSerializer
  end

  private
    def auth_params
      params.permit(:email, :password)
    end
end
