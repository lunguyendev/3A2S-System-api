# frozen_string_literal: true

class Api::V1::Admin::UserController < AdminController
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

  def staff
    raise Errors::ExceptionHandler::InvalidAction if target_user.staff?

    target_user.staff!
    head :accepted
  end

  private
    def target_user
      @user ||= User.find(params[:uid])
    end
end
