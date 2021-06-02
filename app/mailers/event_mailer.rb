# frozen_string_literal: true

class EventMailer < ApplicationMailer
  def notificate(email, title, content, contact_info)
    @contact_info = contact_info
    @title = title
    @content = content
    mail(
      to: email,
      subject: title,
    )
  end

  def reset_password(email, token)
    @token = token
    mail(
      to: email,
      subject: "Reset password",
    )
  end
end
