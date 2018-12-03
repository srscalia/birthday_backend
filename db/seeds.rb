puts "Seeding"

users = (1..10).to_a
relations = ['spouse', 'family', 'friend', 'coworker', 'pet']
years = (2015..2018).to_a
months = (1..12).to_a
days = (1..28).to_a
true_false = [true, false]
phone_numbers = ["999-999-9999", "123-456-7890"]
notes_examples =["likes flowers", "hates surprise parties", "mentioned she wanted jewelry", "allergic to chocolate", "likes funfetti cake", "get new address to send a card"]
puts "hi"

puts "deleting users"
User.delete_all
puts 'seeding users'
10.times do
  # pass = Faker::Internet.password
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.free_email, password: "testing123", password_confirmation: "testing123", phone: phone_numbers.sample)
end
puts "Done seeding users."


Reminder.delete_all
200.times do
  Reminder.create(user_id: users.sample, relation: relations.sample, birthday: "#{years.sample}-#{months.sample}-#{days.sample}", person_name: Faker::Name.first_name, send_reminder: true_false.sample, phone: phone_numbers.sample, notes: notes_examples.sample)
end
puts "Done seeding reminders."


Message.delete_all
counter = 1
200.times do
  Message.create(reminder_id: counter, content: "Happy Birthday!!!")
  counter += 1
end
puts "Done seeding messages."
