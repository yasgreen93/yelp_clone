## Yelp clone

A clone on the Yelp website which allows you to place ratings and reviews for restaurants.

#####  Technologies used:
* Ruby on Rails
* Devise for user registration and sessions
* Haml/HTML
* Postgres and Active Record
* Facebook omniauth
* RSpec
* Capybara

### Installation and usage:
##### In your terminal:
```  
git clone https://github.com/yasgreen93/yelp_clone.git

bundle install
```

##### To create the PSQL databases and tables:
```
bin/rake db:create
bin/rake db:create RAILS_ENV=test
bin/rake db:migrate
bin/rake db:migrate RAILS_ENV=test
```

##### To run the RSpec and Capybara tests:
```
rspec
```

#### To run the server and view in localhost:
```
rails s
```
Then in your browser visit:  
[http://localhost:3000/](http://localhost:3000/)

***Yasmin Green***
