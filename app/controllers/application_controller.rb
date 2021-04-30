# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Errors::ExceptionHandler
  before_action :authorize_request

  private
    def authorize_request
      @current_user ||= Auth::Authorization.new(request.headers).execute
    end
end
