# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

folger = Company.find_or_create_by(name: "Folger Shakespeare Library")
project = Project.find_or_create_by(name: "King John", company: folger)
callback = Category.find_or_create_by(name: "Callback")

audition = Audition.find_or_create_by(
  project: project,
  bring: "Headshot and resume",
  prepare: "1 classical 3-5 m monologue",
  category: callback
)
