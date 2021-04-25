# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Errors::ExceptionHandler
  before_action :authorize_request

  private
    def authorize_request
      @current_user ||= Auth::Authorization.new(request.headers).execute
    end

    def check_role_creator
      return if @current_user.creator? || @current_user.admin? || @current_user.approval?

      raise Errors::ExceptionHandler::PermissionDenied, I18n.t("errors.permission_denied")
    end
end
