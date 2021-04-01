# frozen_string_literal: true

include Util::Generation

puts "Start"
password = generate_hash_password("admin")
Lecturer.create(email: "admin@gmail.com", hashed_password: password)

puts "End"
