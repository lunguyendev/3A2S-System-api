# frozen_string_literal: true

class Api::V1::Admin::UserController < AdminController
  include Util::Generation
  def index
    users = User.all
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
    enterprise = Enterprise.create(params_user)
    password = generate_token
    password_user = generate_hash_password(generate_token)
    enterprise.update_attributes(hashed_password: password_user, status: "newer")

    render json: { password: password }, status: :created
  end

  private
    def target_user
      @user ||= User.find(params[:uid])
    end

    def params_user
      params.permit(:email, :name, :phone)
    end
end
