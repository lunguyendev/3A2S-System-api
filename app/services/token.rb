class Token
  def generate_token
    SecureRandom.hex 
  end
end