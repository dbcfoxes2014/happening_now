# [Happening Now](http://happeningnow.today)

[![Coverage Status](https://coveralls.io/repos/dbcfoxes2014/free_candy/badge.png)](https://coveralls.io/r/dbcfoxes2014/free_candy)

### Collaborators (Foxes 2014)
- [Jack Dubnicek](https://github.com/jdubnicek)
- [Chris Prater](https://github.com/cprater)
- [Daniel Petersen](https://github.com/DanJP-)
- [Tom W.](https://github.com/To-mos)
- [Joe Wilmoth](http://github.com/jbwilmoth)

This application was made for our final project at Dev Bootcamp Chicago.





### Specs

* Ruby version: ```1.9.3-p484```

* System dependencies: ```PostreSQL, SSH Access```

* Configuration: ```Rails 4.0.3```

* Database creation: Run ```rake db:create``` to build the database. Migrate the tables with the ```rake db:migrate``` command.

* How to run the test suite: Type ```rake``` in your console to run the tests and ensure the application is working as it should.

* Server: ```Ubuntu 12.04.3 / Ruby 1.9.3-p484 Source / Apache2 / Phusion Passenger / Redis / PostgreSQL / Rails 4.0.3 / NodeJS / RubyGems 1.9.1```

* Deployment: This app is deployed through ```ssh``` with ```git``` and ```Capistrano 3.1.0```. Run ```bundle install``` then deploy with ```deploy```.

* Start Redis: ```redis-server /usr/local/etc/redis.conf```

* Start Sidekiq: ```bundle exec sidekiq```

* Run ```rails s``` and type ```localhost:3000``` in your browser to launch the Rails server.

### API's

* Instagram: You will need a client id and secret key from Instagram to use the API. Save a ```instagram.yml``` file to the ```root``` of the ```config``` directory.


> [ventiview.co](http://ventiview.co)
