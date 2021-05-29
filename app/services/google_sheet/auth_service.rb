# frozen_string_literal: true

class GoogleSheet::AuthService
  def execute
    GoogleDrive::Session.from_service_account_key("client_secret.json")
  end
end
