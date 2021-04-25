# frozen_string_literal: true

class Api::V1::UserController < ApplicationController
  skip_before_action :authorize_request, only: :login

  def login
    authenticator = Auth::Authentication.new(auth_params[:email], auth_params[:password])

    unless authenticator.authenticable?
      head :unauthorized
      return
    end

    render json: authenticator.authenticated_user, serializer: Api::V1::User::LoginSerializer
  end

  def logout
    head :ok
  end

  def ping_role
    render json: { role: @current_user.role }
  end

  private
    def auth_params
      params.permit(:email, :password)
    end
end
