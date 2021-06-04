# frozen_string_literal: true

class Api::V1::Creator::UserController < ApplicationController
  def index
    render json: User.basic.actived.pluck(:email)
  end

  def send_email
    send_from = "#{mail_params[:send_from]} <#{@current_user.email}>"
    title = mail_params[:title]
    content = mail_params[:content]
    emails_address = mail_params[:emails_address].join(",")
    EventMailer.notificate(emails_address, title, content, send_from).deliver_later
    save_email

    head :ok
  end

  private
    def mail_params
      params.require(:email)
      .permit(
        :send_from,
        :title,
        :content,
        emails_address: []
      )
    end

    def save_email
      Email.create!(
        title: mail_params[:title],
        content: mail_params[:content],
        list_email: mail_params[:emails_address],
        send_by: @current_user.email,
      )
    end
end
