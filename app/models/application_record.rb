# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include Util::Generation

  self.abstract_class = true
  before_validation(on: :create) do
    self.uid = generate_uid
  end
end
