# frozen_string_literal: true

module Util::JsonWebToken
  ALGORITHM = "HS256"

  def encode(payload, exp = 6.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, auth_secret, ALGORITHM)
  end

  def decode(token)
    JWT.decode(token, auth_secret, true, { algorithm: ALGORITHM }).first
  end

  def auth_secret
    ENV["JWT_SECRET"]
  end
end
