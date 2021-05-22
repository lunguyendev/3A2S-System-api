# frozen_string_literal: true

class GoogleCalendar::AuthClient
  require "google/apis/calendar_v3"
  require "googleauth"
  require "googleauth/stores/file_token_store"
  require "date"
  require "fileutils"

  def authorize
    client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
    token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
    authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
    user_id = "default"
    credentials = authorizer.get_credentials user_id
    if credentials.nil?
      url = authorizer.get_authorization_url base_url: OOB_URI
      puts "Open the following URL in the browser and enter the " \
           "resulting code after authorization:\n" + url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI
      )
    end
    @client = Google::Apis::CalendarV3::CalendarService.new
    @client.client_options.application_name = APPLICATION_NAME
    @client.authorization = credentials
    @client
  end

  protected
    OOB_URI = "urn:ietf:wg:oauth:2.0:oob"
    APPLICATION_NAME = "Google Calendar API Ruby Quickstart"
    CREDENTIALS_PATH = "credentials.json"
    TOKEN_PATH = "token.yaml"
    SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR
end
