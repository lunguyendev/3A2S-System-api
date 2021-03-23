# frozen_string_literal: true

class User < ApplicationRecord
  enum status: %i(actived, in_actived)
end
