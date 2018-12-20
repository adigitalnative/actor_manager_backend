# Actio: Actor Career Mangement (Backend)

## Setup & Running the App

### Database

Make sure postgres is running with the standard/default config, or adjust /config files to account for your system.

Setup is fairly standard Ruby/Rails. There is a robust seed with some necessary defaults, so you should use db:setup to get things going. It will create a default user and password, but you can also create your own users.

Setup the app, create and seed the db with:

`bundle install` and `rails db:setup`

After that, you can always start up the server with:

`rails s -p 3001`

(The app can run on any port you like, but the matching frontend will look for localhost:3001)

## Testing

There is a relatively robust rspec test suite. Use `rspec` to run the specs.

## Credits

Created by Jacqueline Chenault (@adigitalnative)
