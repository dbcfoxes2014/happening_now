# [Happening Now](http://happeningnow.today)

### Collaborators (Foxes 2014)
- [Jack Dubnicek](https://github.com/jdubnicek)
- [Chris Prater](https://github.com/cprater)
- [Daniel Petersen](https://github.com/DanJP-)
- [Tom W.](https://github.com/To-mos)
- [Joe Wilmoth](http://github.com/jbwilmoth)

This application was made for our final project at Dev Bootcamp Chicago.

#### Current Version: 1.23.45

[Commit Log](https://github.com/dbcfoxes2014/free_candy/commits/master)

..Features..

* Landing Page for UI
* User Navigation Bar
* Popular Media
* Search for Events by Instagram Tags
* Search for Events by Eventbrite Keywords
* Search Eventbrite location and bounce longitude and latitude back to Instagram to pull media for Event
* Recent User Created Media
* User Profile with Created Media
* User Created Slideshows
* User Video Editor for compiling Instagram videos
* Share User Created Media on Facebook

## Database

The application requires a postgreSQL database to be set up on your environment. You will also need to install and run Redis with default settings.

## API Keys

The application requires you to have developer access tokens to the Instagram and EventBrite API's.

## O-AUTH

The application requires you to have a Facebook account to share media with your friends.

## Clone

If you want to copy the repository to review our code, you'll need ```git``` installed on your environment.

Open Terminal and type ```git clone https://github.com/dbcfoxes2014/free_candy``` to clone.

## Generate

If you want to use the project for review, you'll need to run ```bundle install``` in the root directory of the application. Then run ```rake db:setup``` to migrate the database schema.

Once you have installed the application run ```rails s``` to start the rails server. Go to ```localhost:3000``` in your browser to see the home page.

To enable video creation you need to enable Redis by running ```redis-server``` in a new Terminal tab.

Then open another tab in the same shell and type ```bundle exec sidekiq``` from the root of the application directory.

# Production Version

The application is online at [Happening Now](http://happeningnow.today).

## Web Server

* [Ubuntu](http://releases.ubuntu.com/12.10/) 12.10 2GB RAM and 2 CPU's
* [postgreSQL 9.1](http://www.postgresql.org/docs/9.1/static/)
* [NginX](http://wiki.nginx.org/Main)
* [Unicorn](http://unicorn.bogomips.org/)
* [Redis](http://redis.io)
* [Sidekiq](http://sidekiq.org/)
* [FFmpeg](http://www.ffmpeg.org/)
* [RVM Ruby 2.0.0-p353](https://rvm.io/)
* [Rails 4](http://rubyonrails.org/download/)

## Testing

[![Coverage Status](https://coveralls.io/repos/dbcfoxes2014/free_candy/badge.png)](https://coveralls.io/r/dbcfoxes2014/free_candy)

* Travis
* Coveralls
* Capybara
* RSpec

Run tests locally by typing ```rake``` in the root directory of the application.