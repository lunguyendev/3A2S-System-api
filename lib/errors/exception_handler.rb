# frozen_string_literal: true

module Errors::ExceptionHandler
  extend ActiveSupport::Concern
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class InvalidAction < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from Errors::ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from Errors::ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from Errors::ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from Errors::ExceptionHandler::InvalidAction, with: :bad_request

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  private
    def four_twenty_two(e)
      render json: { message: e.message }, status: :unprocessable_entity
    end

    def unauthorized_request(e)
      render json: { message: e.message }, status: :unauthorized
    end

    def bad_request(e)
      render json: { message: e.message }, status: :bad_request
    end
end
