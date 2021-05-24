# frozen_string_literal: true

class Api::V1::Admin::UserController < AdminController
  include Util::Generation
  def index
    users = User.not_admin.order("email ASC")
    render json: users, each_serializer: Api::V1::Admin::UserSerializer
  end

  def ban
    raise Errors::ExceptionHandler::InvalidAction if target_user.inactived?

    target_user.inactived!
    head :accepted
  end

  def unban
    raise Errors::ExceptionHandler::InvalidAction if target_user.actived?

    target_user.actived!
    head :accepted
  end

  def creator
    raise Errors::ExceptionHandler::InvalidAction if target_user.creator?

    target_user.creator!
    head :accepted
  end

  def approval
    raise Errors::ExceptionHandler::InvalidAction if target_user.approval?

    target_user.approval!
    head :accepted
  end

  def basic
    raise Errors::ExceptionHandler::InvalidAction if target_user.basic?

    target_user.basic!
    head :accepted
  end

  def create
    enterprise = Enterprise.create!(params_user)
    token = enterprise.create_token

    render json: { token: token.qr_code_string }, status: :created
  end

  private
    def target_user
      @user ||= User.find(params[:uid])
    end

    def params_user
      params.permit(:email, :name, :phone)
    end
end
