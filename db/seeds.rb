# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(
             email: "admin@newnil.com",
             password: "Qwer1234",
             password_confirmation: "Qwer1234",
             role: "admin")
Keyword.create!(
              keyword: "BUTTON_2_1",
              hidden: 0)
Keyword.create!(
              keyword: "BUTTON_2_2",
              hidden: 0)