# frozen_string_literal: true

class TypeEvent < ApplicationRecord
  has_many :suggestions, foreign_key: :type_event_uid, primary_key: :uid
end
