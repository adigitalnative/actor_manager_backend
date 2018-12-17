# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

jq = User.create(email: "jq@nativefoundry.com", password: "password",
  first_name: "Jacqueline", last_name: "Chenault")
jane = User.create(email: 'jane@doe.com', password: 'password',
  first_name: "Jane", last_name: "Doe")

folger = Company.find_or_create_by(name: "Folger Shakespeare Library", user: jq)
project = Project.find_or_create_by(name: "King John", company: folger, user: jq)
categories = Category.create([
  {name: "Open Call"},
  {name: "EPA"},
  {name: "Invited Audition"},
  {name: "Callback"}
  ])

BookItem.find_or_create_by(title: "King John", role: "Constance", user: jq)

# Results
not_cast = Result.find_or_create_by(name: "Not Cast")
offered_role = Result.find_or_create_by(name: "Offered Role")
declined = Result.find_or_create_by(name: "Declined Role")

audition = Audition.find_or_create_by(
  project: project,
  bring: "Headshot and resume",
  prepare: "1 classical 3-5 m monologue",
  category: Category.all[2],
  user: jq
)

audition = Audition.find_or_create_by(
  project: project,
  bring: "Headshot and resume",
  prepare: "1 classical 3-5 m monologue",
  category: Category.all[3],
  user: jq
)
