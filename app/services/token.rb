# frozen_string_literal: true

class Token
  def generate_token
    SecureRandom.hex
  end
end
