# frozen_string_literal: true

class Api::V1::EmailController < ApplicationController
  def index
    if @current_user.admin?
      emails = Email.all.order("created_at DESC")
    else
      emails = Email.search_by_email(@current_user.email).order("created_at DESC")
    end

    render json: emails, each_serializer: Api::V1::EmailSerializer
  end

  def show
    render json: target_email, serializer: Api::V1::EmailSerializer
  end

  def email_by_me
    emails = Email.where(send_by: @current_user.email).order("created_at DESC")

    render json: emails, each_serializer: Api::V1::EmailSerializer
  end

  private
    def target_email
      @email ||= Email.find(params[:uid])
    end
end
