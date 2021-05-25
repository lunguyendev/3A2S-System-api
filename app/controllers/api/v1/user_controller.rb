# frozen_string_literal: true

class Api::V1::UserController < ApplicationController
  include Util::Generation
  skip_before_action :authorize_request, only: [:login, :change_password]

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

  def change_password
    user = User.find(token_valid.qr_code_id)
    password_user = generate_hash_password(change_password_params[:password])
    ApplicationRecord.transaction do
      user.update_attributes!(hashed_password: password_user, status: "actived", role: "creator")
      token_valid.destroy!
    end
  end

  def search_email
    users = User.not_admin.where("email LIKE ?", "%#{params[:search]}%").order("email ASC")

    render json: users, each_serializer: Api::V1::Admin::UserSerializer
  end

  private
    def auth_params
      params.permit(:email, :password)
    end

    def token_valid
      return @token if @token = Token.find_by(qr_code_string: change_password_params[:token])

      raise Errors::ExceptionHandler::InvalidToken
    end

    def change_password_params
      params.require(:change_password)
            .permit(:token, :password)
    end
end
