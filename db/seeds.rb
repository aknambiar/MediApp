# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ActiveRecord::Base.connection.disable_referential_integrity do
  Doctor.delete_all
  ActiveStorage::Attachment.all.each(&:purge)
  Client.delete_all
  Appointment.delete_all
end

Doctor.create!(name: 'Neha Kakkar', location: 'Mumbai').avatar.attach(
    io: File.open('db/seed_avatars/img1.png'),
    filename: 'img1.png'
  )
Doctor.create!(name: 'Rhea Mhatre', location: 'Delhi', working_hours: "12,14,15,16,17,20").avatar.attach(
    io: File.open('db/seed_avatars/img2.png'),
    filename: 'img2.png'
  )
Doctor.create!(name: 'Neha Kakkar', location: 'Bangalore').avatar.attach(
    io: File.open('db/seed_avatars/img1.png'),
    filename: 'img1.png'
  )
Doctor.create!(name: 'Rhea Mhatre', location: 'Hyderabad').avatar.attach(
    io: File.open('db/seed_avatars/img2.png'),
    filename: 'img2.png'
  )
Doctor.create!(name: 'Neha Kakkar', location: 'Chennai').avatar.attach(
    io: File.open('db/seed_avatars/img1.png'),
    filename: 'img1.png'
  )
Doctor.create!(name: 'Rhea Mhatre', location: 'Bangalore').avatar.attach(
    io: File.open('db/seed_avatars/img2.png'),
    filename: 'img2.png'
  )

Client.create(email: 'am@mail.com')
Client.create(email: 'pk@mail.com')
Client.create(email: 'sd@mail.com')

Appointment.create(date: DateTime.now.strftime("%d/%m/%Y"), time: '12', paid_amount: 500, doctor: Doctor.where(name: 'Neha Kakkar').first, client: Client.where(email: 'am@mail.com').first)
