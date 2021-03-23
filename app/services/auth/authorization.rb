# frozen_string_literal: true

class Auth::Authorization
  include Util::JsonWebToken

  def initialize(headers = {})
    @headers = headers
  end

  def execute
    user
  end

  private
    attr_reader :headers

    def user
      User.find(decoded_token["user_uid"]) if decoded_token
    rescue ActiveRecord::RecordNotFound
      raise Errors::ExceptionHandler::InvalidToken, I18n.t("errors.invalid_token")
    end

    def decoded_token
      decode(http_auth_header)
    end

    def http_auth_header
      return headers["Authorization"] if headers["Authorization"].present?

      raise Errors::ExceptionHandler::MissingToken, I18n.t("errors.missing_token")
    end
end
