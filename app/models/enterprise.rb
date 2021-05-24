# frozen_string_literal: true

class Enterprise < User
  has_one :token, as: :qr_code
end
