# frozen_string_literal: true

class Api::V1::EmailController < ApplicationController
  def index
    if @current_user.admin?
      emails = Email.all
    else
      emails = Email.search_by_email(@current_user.email)
    end

    render json: emails, each_serializer: Api::V1::EmailSerializer
  end

  def show
    render json: target_email, serializer: Api::V1::EmailSerializer
  end

  def email_by_me
    emails = Email.where(send_by: @current_user.email)

    render json: emails, each_serializer: Api::V1::EmailSerializer
  end

  private
    def target_email
      @email ||= Email.find(params[:uid])
    end
end
