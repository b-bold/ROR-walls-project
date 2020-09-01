# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Delete all records
Wall.destroy_all

# Reset the primary key sequence so that the first id is 1
ApplicationRecord.connection.reset_pk_sequence!('walls')

#seed the walls table
beacon = Wall.create!(construction_date: "2020-3-4", wall_material: "wood", name: "Comm Ave", description: "this is a gorgeous wall near lots of people walking around", size: "large")
verdun = Wall.create!(construction_date: "1987-3-4", wall_material: "cement", name: "Verdun Street", size: "small", description: "The wall is in a lovely neighborhood of mostly Irish immigrants")
fourth = Wall.create!(construction_date: "2016-5-20", wall_material: "concrete", name: "East Fourth Street", size: "medium", description: "Location is in the middle of Southie in a pretty yuppie neighborhood")
highland = Wall.create!(construction_date: "2018-9-12", wall_material: "clay", name: "Highland Avenue", size: "medium", description: "this wall is on a high traffic street in Somerville")

# seed the wall_rental_requests table 
first_request = WallRentalRequest.create!(wall_id: beacon.id, start_date: "2020-4-1", end_date: "2020-5-1", status: "APPROVED")
second_request = WallRentalRequest.create!(wall_id: beacon.id, start_date: "2020-6-1", end_date: "2020-7-8", status: "DENIED")
third_request = WallRentalRequest.create!(wall_id: verdun.id, start_date: "1988-2-1", end_date: "1990-1-1", status: "APPROVED")
fourth_request = WallRentalRequest.create!(wall_id: verdun.id, start_date: "2020-1-15", end_date: "2020-4-7", status: "APPROVED")
overlapping_one = WallRentalRequest.create!(wall_id: beacon.id, start_date: "2020-4-1", end_date: "2020-4-6", status: "APPROVED")
overlapping_two = WallRentalRequest.create!(wall_id: beacon.id, start_date: "2020-2-1", end_date: "2020-5-1", status: "APPROVED")
overlapping_three = WallRentalRequest.create!(wall_id: beacon.id, start_date: "2020-4-3", end_date: "2020-5-6", status: "APPROVED")
overlapping_four = WallRentalRequest.create!(wall_id: beacon.id, start_date: "2020-3-1", end_date: "2020-4-5", status: "APPROVED")
