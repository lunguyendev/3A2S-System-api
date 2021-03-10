class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def uuid
    Digest::SHA256.base64digest(SecureRandom.alphanumeric(10)).delete("=/+")
  end
end
