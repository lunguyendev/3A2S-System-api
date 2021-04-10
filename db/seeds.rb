# frozen_string_literal: true

include Util::Generation

puts "Start"
# Config defaut language
Faker::Config.locale = :vi

# Create account user
password_user = generate_hash_password("password123")
student = Student.create(email: "student_01@dtu.edu.com", hashed_password: password_user)

password_lecturer = generate_hash_password("password123")
lecture = Lecturer.create(email: "lecture_01@dtu.edu.com", hashed_password: password_lecturer)

# Create event
(1..5).to_a.each do |index|
  param_event = {
    event_name: "Sự kiện " + Faker::Job.title,
    type_event: (1..7).to_a.sample,
    size: [100, 200, 500, 700, 1000].sample,
    organization: Faker::Company.name,
    description: Faker::Lorem.paragraph_by_chars,
    start_at: DateTime.now + 1.days,
    end_at: DateTime.now + 1.days + 2.hours
  }
  lecture.events.create(param_event)
end

# Update status event
event = Event.first
event.accept!

# Take part in event
TakePartInEvent.create(
  user_uid: student.uid,
  event_uid: event.uid
)

# Generation Token Code
Token.create(qr_code: event, expired_at: Time.now + 2.hours)

puts "End"
