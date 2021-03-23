# frozen_string_literal: true

module Util
  module Generation
    def generate_uid
      Digest::SHA256.base64digest(SecureRandom.uuid).delete("=+/")
    end

    def generate_token
      SecureRandom.hex
    end

    def generate_hash_password(password)
      BCrypt::Password.create(password).to_s
    end
  end
end
