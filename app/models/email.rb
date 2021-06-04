# frozen_string_literal: true

class Email < ApplicationRecord
  scope :search_by_email, -> (email) { where("list_email @> ARRAY[?]::varchar[]", [email]) }
end
