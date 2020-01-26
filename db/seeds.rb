# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Company.destroy_all
Freight.destroy_all
Booking.destroy_all
Port.destroy_all
Review.destroy_all
Document.destroy_all

companies = [
    {
        name: "Empresa",
        cnpj: "42.048.939/0001-76"
    }
]

companies.each { |company| Company.create!(company) }

users = [
    {
        first_name: "Vinicius",
        last_name: "Costa",
        password: "123456",
        email: "vinicius@daleship.com",
        job_title: "Carrier agent",
        user_type: "Carrier",
        company: Company.first
    }, {
        first_name: "Alexandre",
        last_name: "Okubo",
        password: "123456",
        email: "alexandre@daleship.com",
        job_title: "Owner",
        user_type: "Shipper",
        company: Company.first
    }
]

users.each { |user| User.create!(user) }

rand(5..10).times do
  Review.create!(rating: rand(1..5), comment: "comentário", user: User.first, company: Company.first)
end

ports = [
    {
        name: "Porto 1",
        zipcode: "08735-440",
        street: "Rua Francisco Vaz Coelho",
        number: 819,
        city: "Santos",
        state: "SP",
        country: "BR"
    }, {
        name: "Porto 2",
        zipcode: "05410-002",
        street: "Rua Alves Guimarães",
        number: 1133,
        city: "Recife",
        state: "PE",
        country: "BR"
    }
]

ports.each { |port| Port.create!(port) }

freights = [
    {
        modal: "modal",
        origin_port: Port.first,
        destination_port: Port.last,
        load_type: "load",
        shipment_type: "shipment",
        container_pack: "pack",
        expiration_date: Date.tomorrow,
        price_per_container: 10000,
        ship_owner: "Owner",
        user: User.first
    }
]

freights.each { |freight| Freight.create!(freight) }

bookings = [
    {
        freight: Freight.first,
        load_date: Date.tomorrow,
        quantity_of_containers: 3,
        user: User.last
    }
]

bookings.each { |booking| Booking.create!(booking) }