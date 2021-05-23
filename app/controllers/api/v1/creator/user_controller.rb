# frozen_string_literal: true

class Api::V1::Creator::UserController < ApplicationController
  def index
    render json: User.basic.pluck(:email)
  end
end