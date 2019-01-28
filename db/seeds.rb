# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
FlightSourceDestination.create(name: "Agatti Island Airport",code: "AGX",city:"Agatti Island")
FlightSourceDestination.create(name: "Ahmedabad Airport",code: "AMD",city:"Ahmedabad")
FlightSourceDestination.create(name: "Aizawl Airport ",code: "AJL",city:"Aizawl")
FlightSourceDestination.create(name: "Akola Airport",code: "AKD",city:"Akola")
FlightSourceDestination.create(name: "Along Airport",code: "IXV",city:"Along")
FlightSourceDestination.create(name: "Amausi Airport",code: "LKO",city:"Lucknow")
FlightSourceDestination.create(name: "Amritsar Airport",code: "LUH",city:"Ludhiana")
SeatCategory.create(name: "First Class")
SeatCategory.create(name: "Business Class")
SeatCategory.create(name: "Economy Class")
#https://www.prokerala.com/travel/airports/india/#A