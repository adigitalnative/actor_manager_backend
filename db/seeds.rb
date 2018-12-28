# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Make Categories
openCall = Category.find_or_create_by(name: "Open Call")
epa = Category.find_or_create_by(name: "EPA")
invitedAudition = Category.find_or_create_by(name: "Invited Audition")
callback = Category.find_or_create_by(name: "Callback")

# Make Results
not_cast = Result.find_or_create_by(name: "Not Cast")
offered_role = Result.find_or_create_by(name: "Offered Role")
accepted_role = Result.find_or_create_by(name: "Accepted Role")
declined = Result.find_or_create_by(name: "Declined Role")

# Build States
states = State.create([
    { name: 'AL'},
    { name: 'AK'},
    { name: 'AZ'},
    { name: 'AR'},
    { name: 'CA'},
    { name: 'CO'},
    { name: 'CT'},
    { name: 'DE'},
    { name: 'FL'},
    { name: 'GA'},
    { name: 'HI'},
    { name: 'ID'},
    { name: 'IL'},
    { name: 'IN'},
    { name: 'IA'},
    { name: 'KS'},
    { name: 'KY'},
    { name: 'LA'},
    { name: 'ME'},
    { name: 'DC'},
    { name: 'MD'},
    { name: 'MA'},
    { name: 'MI'},
    { name: 'MN'},
    { name: 'MS'},
    { name: 'MO'},
    { name: 'MT'},
    { name: 'NE'},
    { name: 'NV'},
    { name: 'NH'},
    { name: 'NJ'},
    { name: 'NM'},
    { name: 'NY'},
    { name: 'NC'},
    { name: 'ND'},
    { name: 'OH'},
    { name: 'OK'},
    { name: 'OR'},
    { name: 'PA'},
    { name: 'RI'},
    { name: 'SC'},
    { name: 'SD'},
    { name: 'TN'},
    { name: 'TX'},
    { name: 'UT'},
    { name: 'VT'},
    { name: 'VA'},
    { name: 'WA'},
    { name: 'WV'},
    { name: 'WI'},
    { name: 'WY'}
  ])

# Build sample users for demos
jq = User.create(email: "jq@nativefoundry.com", password: "password",
  first_name: "Jacqueline", last_name: "Chenault")
jane = User.create(email: 'jane@doe.com', password: 'password',
  first_name: "Jane", last_name: "Doe")

b_sides = BookItem.where(user: jq, title: "Prepared Sides")
b_kingJohn = BookItem.find_or_create_by(title: "King John", role: "Constance", author: "Shakespeare", user: jq)
b_prologue = BookItem.find_or_create_by(title: "Henry VI", role: "Prologue", author: "Shakespeare", user: jq)
b_izzy = BookItem.find_or_create_by(title: "Rabbit Hole", role: "Izzy", author: "David-Lindsay Abaire", user: jq)
b_juliet = BookItem.find_or_create_by(title: "Romeo & Juliet", role: "Juliet [the ball]", author: "Shakespeare", user: jq)
b_lpercy = BookItem.find_or_create_by(title: "Henry IV Pt 2", role: "Lady Percy", author: "Shakespeare", user: jq)

folger = Company.find_or_create_by(name: "Folger Shakespeare Library", user: jq)
davenantMacb = Project.find_or_create_by(name: "Davenant's Scottish Play", company: folger, user: jq, result: not_cast)
pericles = Project.find_or_create_by(name: "Pericles", company: folger, user: jq, result: offered_role)

braveSpirits = Company.find_or_create_by(name: "Brave Spirits Theatre", user: jq)
history = Project.find_or_create_by(name: "History is 2020", company: braveSpirits, user: jq, result: offered_role)

psp = Company.find_or_create_by(name: "Pinky Swear Productions", user: jq)
blight = Project.find_or_create_by(name: "Blight", company: psp, user: jq, result: offered_role)

blightAud = Audition.find_or_create_by(
  project: blight,
  bring: "2 copies HS + Resume",
  prepare: "Sides",
  category: openCall,
  user: jq,
)

blightAud.book_items << b_izzy
blightAud.book_items << b_sides
blightAud.save

pericAudOne = Audition.find_or_create_by(
  project: pericles,
  bring: "1 copy Headshot and resume",
  prepare: "1 classical 3-5 m monologue",
  category: epa,
  user: jq,
)

pericAudOne.book_items << b_prologue
pericAudOne.save

pericAudOne.report.update(
  audition: pericAudOne,
  notes: "Prepped a bunch in advance. OSF team was awesome in the room",
  auditors: "OSF stage management team, Folger casting director"
)

pericAudTwo = Audition.find_or_create_by(
  project: pericles,
  bring: "nothing",
  prepare: "sides for Lychorida",
  category: invitedAudition,
  user: jq
)

pericAudTwo.book_items << b_sides
pericAudTwo.save


pericAudTwo.report.update(
  auditors: "OSF stage management team, Folger casting director"
)

davenantAud = Audition.find_or_create_by(
  project: davenantMacb,
  category: invitedAudition,
  bring: "2 copies HS + resume",
  prepare: "Provided sides, song",
  user: jq,
)

davenantAud.book_items << b_sides
davenantAud.save

historiesOne = Audition.find_or_create_by(
  project: history,
  category: invitedAudition,
  bring: "2 copies hs + resume",
  prepare: "Your choice of 1 of the provided sides",
  user: jq,
)

historiesOne.book_items << b_sides
historiesOne.save

historiesOne.report.update(
  notes: "Didn't have much time to prep, but team knew walking in.",
  auditors: "Charlene, Jordan",
  people: "The standard DC Shakespeare gang: Brendan, Bri, Amber, et al"
)

historiesTwo = Audition.find_or_create_by(
  project: history,
  category: callback,
  bring: "optional: instrument to use in improv",
  prepare: "Indicated sides, review HVI P2 for improv",
  user: jq,
)

historiesTwo.book_items << b_sides
historiesTwo.save

historiesThree = Audition.find_or_create_by(
  project: history,
  category: callback,
  bring: "nothing",
  prepare: "Provided sides for Richard II",
  user: jq,
)

historiesThree.book_items << b_sides
historiesThree.save

historiesThree.report.update(
  auditors: "Charlene",
  people: "Read with Brendan, he was also reading for Richard II as well as Hotspur",
)
