# frozen_string_literal: true

class Util::JsonWebToken
  ALGORITHM = "HS256"

  def self.encode(payload)
    JWT.encode(payload, auth_secret, ALGORITHM)
  end

  def self.decode(token)
    JWT.decode(token, auth_secret, true, { algorithm: ALGORITHM }).first
  end

  def self.auth_secret
    ENV["JWT_SECRET"]
  end
end
