include Util::Generation

puts "Start"
password = generate_hash_password("admin")
lecture = Lecturer.create(email: "admin@gmail.com",hashed_password: password)

puts "End"
