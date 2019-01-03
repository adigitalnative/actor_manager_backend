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
offered_role = Result.find_or_create_by(name: "Offered Role", booked: true)
accepted_role = Result.find_or_create_by(name: "Accepted Role", booked: true)
declined = Result.find_or_create_by(name: "Declined Role", booked: true)

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

studio = Company.find_or_create_by(name: "Studio Theatre", user: jq)
father = Project.find_or_create_by(name: "The Father", company: studio, user: jq, result: accepted_role)
sisters = Project.find_or_create_by(name: "Three Sisters", company: studio, user: jq, result: accepted_role)
wolves = Project.find_or_create_by(name: "The Wolves", company: studio, user: jq, result: not_cast)

folger = Company.find_or_create_by(name: "Folger Shakespeare Library", user: jq)
davenantMacb = Project.find_or_create_by(name: "Davenant's Scottish Play", company: folger, user: jq, result: not_cast)
pericles = Project.find_or_create_by(name: "Pericles", company: folger, user: jq, result: accepted_role)
rg = Project.find_or_create_by(name: "Rosencrantz and Guildenstern are Dead", company: folger, user: jq, result: accepted_role)
ssp = Project.find_or_create_by(name: "Second Shepherd's Play", company: folger, user: jq, result: accepted_role)
msnd = Project.find_or_create_by(name: "A Midsummer Night's Dream", company: folger, user: jq, result: accepted_role)

fort = Company.find_or_create_by(name: "4615 Theatre Company", user: jq)
electra = Project.find_or_create_by(name: "Electra", company: fort, user: jq, result: accepted_role)
kingJohn = Project.find_or_create_by(name: "King John", company: fort, user: jq, result: accepted_role)
venus = Project.find_or_create_by(name: "Venus in Fur", company: fort, user: jq, result: not_cast)

braveSpirits = Company.find_or_create_by(name: "Brave Spirits Theatre", user: jq)
history = Project.find_or_create_by(name: "History is 2020", company: braveSpirits, user: jq, result: offered_role)
tnk = Project.find_or_create_by(name: "Two Noble Kinsmen", company: braveSpirits, user: jq, result: accepted_role)

psp = Company.find_or_create_by(name: "Pinky Swear Productions", user: jq)
blight = Project.find_or_create_by(name: "Blight", company: psp, user: jq, result: accepted_role)

blightAud = Audition.find_or_create_by(
  project: blight,
  bring: "2 copies HS + Resume",
  prepare: "Sides",
  category: openCall,
  user: jq,
  date_and_time: DateTime.now+(rand(1..365))
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
  date_and_time: DateTime.now+(rand(1..365))
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
  user: jq,
  date_and_time: DateTime.now+(rand(1..365))
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
  date_and_time: DateTime.now+(rand(1..365))
)

davenantAud.book_items << b_sides
davenantAud.save

historiesOne = Audition.find_or_create_by(
  project: history,
  category: invitedAudition,
  bring: "2 copies hs + resume",
  prepare: "Your choice of 1 of the provided sides",
  user: jq,
  date_and_time: "Fri, Sep 14, 2018 at 5:00 pm"
)

historiesOne.book_items << b_sides
historiesOne.save

historiesOne.report.update(
  notes: "Didn't have much time to prep, but the casting team was aware.",
  auditors: "Charlene Smith, Jordan Friend",
  people: "Bri, Brendan, Jill, and the rest of the standard DC Shakespeare gang."
)

historiesTwo = Audition.find_or_create_by(
  project: history,
  category: callback,
  bring: "optional: instrument to use in improv",
  prepare: "Indicated sides, review HVI P2 for improv",
  user: jq,
  date_and_time: "Sat, Dec 1, 2018 at 5:00 pm"
)

historiesTwo.book_items << b_sides
historiesTwo.save

historiesThree = Audition.find_or_create_by(
  project: history,
  category: callback,
  bring: "nothing",
  prepare: "Provided sides for Richard II",
  user: jq,
  date_and_time: "Sat, Dec 8, 2018 at 6:30 pm"
)

historiesThree.book_items << b_sides
historiesThree.save

historiesThree.report.update(
  auditors: "Charlene",
  people: "Read with Brendan, he was also reading for Richard II as well as Hotspur",
)

fatherOne = Audition.find_or_create_by(
  project: father,
  category: invitedAudition,
  bring: "1 copy of Headshot & Resume",
  prepare: "Provided sides",
  user: jq,
  date_and_time: DateTime.now+(rand(1..365))
)

fatherOne.book_items << b_sides
fatherOne.save

sistersOne = Audition.find_or_create_by(
  project: sisters,
  category: invitedAudition,
  bring: "1 copy of Headshot & Resume",
  prepare: "Provided sides",
  user: jq,
  date_and_time: DateTime.now+(rand(1..365))
)

sistersOne.book_items << b_sides
sistersOne.save

wolvesOne = Audition.find_or_create_by(
  project: wolves,
  category: epa,
  bring: "1 copy of Headshot & Resume",
  prepare: "Short contemporary monologue",
  user: jq,
  date_and_time: DateTime.now+(rand(1..365))
)

wolvesOne.book_items << b_izzy
wolvesOne.save

rgOne = Audition.find_or_create_by(
  project: rg,
  category: epa,
  bring: "1 copy of Headshot & Resume",
  prepare: "Classical Monologue",
  user: jq,
  date_and_time: DateTime.now+(rand(1..365))
)

rgOne.book_items << b_prologue
rgOne.save

rgTwo = Audition.find_or_create_by(
  project: rg,
  category: invitedAudition,
  bring: "2 copies of Headshot & Resume",
  prepare: "Prepared Sides",
  user: jq,
  date_and_time: DateTime.now+(rand(1..365))
)

rgTwo.book_items << b_sides
rgTwo.save

sspOne = Audition.find_or_create_by(
  project: ssp,
  category: invitedAudition,
  bring: "2 copies of Headshot & Resume",
  prepare: "Prepared Sides & a period song or carol",
  user: jq,
  date_and_time: DateTime.now+(rand(1..365))
)

sspOne.book_items << b_sides
sspOne.save

msndFolgOne = Audition.find_or_create_by(
  project: msnd,
  category: invitedAudition,
  bring: "2 copies of Headshot & Resume",
  prepare: "Prepared Sides",
  user: jq,
  date_and_time: DateTime.now+(rand(1..365))
)

msndFolgOne.book_items << b_sides
msndFolgOne.save

electraOne = Audition.find_or_create_by(
  project: electra,
  category: invitedAudition,
  bring: "1 copies of Headshot & Resume",
  prepare: "Prepared Sides",
  user: jq,
  date_and_time: DateTime.now+(rand(1..365))
)

electraOne.book_items << b_sides
electraOne.save

kingJohnOne = Audition.find_or_create_by(
  project: kingJohn,
  category: invitedAudition,
  bring: "1 copies of Headshot & Resume",
  prepare: "Prepared Sides",
  user: jq,
  date_and_time: DateTime.now+(rand(1..365))
)

kingJohnOne.book_items << b_sides
kingJohnOne.save

venusOne = Audition.find_or_create_by(
  project: venus,
  category: invitedAudition,
  bring: "1 copies of Headshot & Resume",
  prepare: "Prepared Sides",
  user: jq,
  date_and_time: DateTime.now+(rand(1..365))
)

venusOne.book_items << b_sides
venusOne.save

tnkOne = Audition.find_or_create_by(
  project: tnk,
  category: invitedAudition,
  bring: "1 copies of Headshot & Resume",
  prepare: "Classical Monologue",
  user: jq,
  date_and_time: DateTime.now+(rand(1..365))
)

tnkOne.book_items << b_prologue
tnkOne.save


### Set up states seed - this is for the demo ONLY!

Opportunity.source_opportunities(["DC", "MD", "VA", "CO", "MI", "WA"])

Opportunity.create([
  {
    source: "playbill",
    title: "Nomad Motel - NYC EPA (1.6.19)",
    company: "Atlantic Theatre Company",
    url: "http://www.playbill.com/job/nomad-motel-nyc-epa-11619/00000168-142b-d134-a7ed-ff3b990c0000",
    state_id: State.find_by_name("NY")
  },
  {
    source: "playbill",
    title: "Wicked (Broadway, Nat'l Tour #2) - NYC ECC/Male Singers",
    company: "Various Producers",
    url: "http://www.playbill.com/job/wicked-broadway-natl-tour-2-nyc-ecc-male-singers/00000168-0f7f-d69c-af78-8f7f27460000",
    state_id: State.find_by_name("NY")
  },
  {
    source: "playbill",
    title: "Wicked (Broadway, Nat'l Tour #2) - NYC ECC/Female Singers",
    company: "Various Producers",
    url: "http://www.playbill.com/job/wicked-broadway-natl-tour-2-nyc-ecc-female-singers/00000168-0f7d-d093-a76a-af7d71180000",
    state_id: State.find_by_name("NY")
  },
  {
    source: "playbill",
    title: "Oklahoma (Broadway) - NYC ECC/Female Singers (01.04.19)",
    company: "Cain't Say No LLC",
    url: "http://www.playbill.com/job/oklahoma-broadway-nyc-ecc-female-singers-010419/00000168-0f7a-d120-a769-cf7f9cf90000",
    state_id: State.find_by_name("NY")
  },
  {
    source: "playbill",
    title: "Casting 'Bare' a Pop Opera",
    company: "The What Theatre Productions",
    url: "http://www.playbill.com/job/casting-bare-a-pop-opera/00000168-0c0c-dcfd-a3fc-7f3dd8710000",
    state_id: State.find_by_name("NY")
  },
  {
    source: "playbill",
    title: "Call for Female-Identifying Actors",
    company: "M. Beth Productions",
    url: "http://www.playbill.com/job/call-for-female-identifying-actors/00000168-05d8-ddaf-a379-25dc5f650000",
    state_id: State.find_by_name("NY")
  },
  {
    source: "playbill",
    title: "STREB Extreme Action Company",
    company: "STREB, inc",
    url: "http://www.playbill.com/job/streb-extreme-action-company/00000167-f57d-dacb-a567-f77f909a0000",
    state_id: State.find_by_name("NY")
  },
  {
    source: "playbill",
    title: "The Book of Mormon (Broadway) NYC ECC/Female Singers (01.09.19)",
    company: "Book of Mormon Broadway LLC",
    url: "http://www.playbill.com/job/the-book-of-mormon-broadway-nyc-ecc-female-singers-010919/00000167-f07a-d973-abe7-fb7abfcd0000",
    state_id: State.find_by_name("NY")
  },
  {
    source: "playbill",
    title: "The Tempest - NYC EPA",
    company: "New York Shakespeare Festival",
    url: "http://www.playbill.com/job/the-tempest-nyc-epa/00000167-d1a1-d639-a17f-d3b12a9c0000",
    state_id: State.find_by_name("NY")
  },
  {
    source: "playbill",
    title: "Little Shop of Horrors - Chicago EPA - Day 2 of 2",
    company: "Southport Theater LLC/Mercury Theater Chicago",
    url: "http://www.playbill.com/job/little-shop-of-horrors-chicago-epa-day-2-of-2-11519/00000168-1431-db96-a17d-bcf54f630000",
    state_id: State.find_by_name("IL")
  },
  {
    source: "playbill",
    title: "Little Shop of Horrors - Chicago EPA - Day 2 of 2",
    company: "Southport Theater LLC/Mercury Theater Chicago",
    url: "http://www.playbill.com/job/little-shop-of-horrors-chicago-epa-day-1-of-2-11419/00000168-142e-ddf0-ad6a-3d3f52ae0000",
    state_id: State.find_by_name("IL")
  },
  {
    source: "playbill",
    title: "Video Submission: Actor - Phantom/Erik in Yeston & Kopit's Phantom",
    company: "Quincy Community Theatre",
    url: "http://www.playbill.com/job/video-submission-actor-phantom-erik-in-yeston-kopits-phantom/00000167-a9c4-d3b4-a167-edce41d70000",
    state_id: State.find_by_name("IL")
  },
  {
    source: "playbill",
    title: "Remy Bumppo 2019 - 2020 Season - Chicago EPA - Day 3 of 3",
    company: "Remy Bumppo Productions",
    url: "http://www.playbill.com/job/remy-bumppo-2019-2020-season-chicago-epa-day-3-of-3-010918/00000167-8490-d03e-a977-c49271300000",
    state_id: State.find_by_name("IL")
  },
  {
    source: "playbill",
    title: "Remy Bumppo 2019 - 2020 Season - Chicago EPA - Day 2 of 3",
    company: "Remy Bumppo Productions",
    url: "http://www.playbill.com/job/remy-bumppo-2019-2020-season-chicago-epa-day-2-of-3-010819/00000167-848b-d3fe-a9f7-f5abab4d0000",
    state_id: State.find_by_name("IL")
  },
  {
    source: "playbill",
    title: "Remy Bumppo 2019 - 2020 Season - Chicago EPA - Day 3 of 3",
    company: "Remy Bumppo Productions",
    url: "http://www.playbill.com/job/remy-bumppo-2019-2020-season-chicago-epa-day-1-of-3-010719/00000167-8483-d5ae-aff7-97db8f750000",
    state_id: State.find_by_name("IL")
  },
  {
    source: "playbill",
    title: "The Root Beer Bandits",
    company: "Garry Marshall Theatre",
    url: "http://www.playbill.com/job/the-root-beer-bandits-burbank-epa/00000167-d1eb-d18d-aff7-dbef8f210000",
    state_id: State.find_by_name("CA")
  },
  {
    source: "playbill",
    title: "Santa Cruz Shakespeare 2019 Season - Los Angeles EPA Day 1 of 2 (01.23.19)",
    company: "Shakespeare Play On DBA Santa Cruz Shakespeare",
    url: "http://www.playbill.com/job/santa-cruz-shakespeare-2019-season-los-angeles-epa-day-1-of-2-012319/00000167-d1c5-d18d-aff7-dbcd0d750000",
    state_id: State.find_by_name("CA")
  },
  {
    source: "playbill",
    title: "La Jolla Playhouse 2019-20 Season - NYC EPA",
    company: "La Jolla Playhouse",
    url: "http://www.playbill.com/job/la-jolla-playhouse-2019-20-season-nyc-epa/00000167-c864-dcdf-ade7-fb655b440000",
    state_id: State.find_by_name("CA")
  },
  {
    source: "playbill",
    title: "Crowded Fire 2019 Season - San Francisco EPA",
    company: "Crowded Firehouse Theater Company",
    url: "http://www.playbill.com/job/crowded-fire-2019-season-san-francisco-epa/00000167-7ee8-de7c-af6f-7ff877290000",
    state_id: State.find_by_name("CA")
  },
  {
    source: "playbill",
    title: "Chess - Los Angeles Appointments",
    company: "Coachella Valley Repertory",
    url: "http://www.playbill.com/job/chess-los-angeles-appointments/00000167-79ed-d5e8-a967-7bed17ca0000",
    state_id: State.find_by_name("CA")
  }
  ])
