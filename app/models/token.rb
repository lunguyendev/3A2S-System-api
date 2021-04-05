# frozen_string_literal: true

class Token < ActiveRecord::Base
  include Util::Generation

  belongs_to :qr_code, polymorphic: true

  before_validation(on: :create) do
    self.qr_code_string = generate_token
  end
end
