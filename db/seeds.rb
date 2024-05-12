# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Supervisor.create(email:'1@email.com', 
name: "Samy",
password: '123123',
password_confirmation: '123123')

Supervisor.create(email:'2@email.com', 
name: "Othman",
password: '123123',
password_confirmation: '123123')

Agent.create(email:'1@email.com', 
name: "Tsadug",
password: '123123',
password_confirmation: '123123')

Agent.create(email:'2@email.com', 
name: "Ali",
password: '123123',
password_confirmation: '123123')

Customer.create(email:'1@email.com', 
name: "Mohammed",
password: '123123',
password_confirmation: '123123')