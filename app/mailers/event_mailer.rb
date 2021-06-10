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

  def approval_event(email, name, name_event)
    @name = name
    @name_event = name_event
    mail(
      to: email,
      subject: "Event approved",
    )
  end

  def cancel_event(email, name, name_event, note)
    @name = name
    @name_event = name_event
    @note = note
    mail(
      to: email,
      subject: "Event denied",
    )
  end
end
