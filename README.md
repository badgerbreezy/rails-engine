# <div align="center"> Rails Engine
  
<div align="center"><img src = "https://i.pinimg.com/originals/17/3f/24/173f243d36aa684370a70e87f8b31abf.png"/></div>

## Rails Engine Functionality
The Rails Engine works in conjunction with the [The Turing Rails Driver](https://github.com/turingschool-examples/rails_driver) and is a Ruby on Rails application that mimics an E-commerce database. The main goal of this project is to develop a back end application in a service-oriented architecture that exposes the data that powers the fictitious E-commerce website through an API consumed by the front end.

## Deployment Link

[Local server port 3001](http://localhost:3001//)

## Requirements
 ### Testing Dependencies
  * capybara
  * rspec-rails
  * launchy
  * simplecov
  * should-matchers
  * factory_bot_rails
  * faker
 ### Configurations
  * Ruby 2.5.3
  * Rails 5.2.4.3

## How to Setup Rails Engine

1. Create a local folder
2. Fork and clone the repo into the local folder
3. Install gem packages: `bundle install`
4. Setup the database: `rails db:{drop,create,migrate}`
5. In CLI run `bundle exec figaro install`
6. Add `RAILS_ENGINE_DOMAIN: http://localhost:3000` to the `config/application.yml` file
7. Fork and clone the [Rails Driver here](https://github.com/turingschool-examples/rails_driver) into the local folder
8. Open one terminal window for rails-engine and run `rails s`
9. While the window is open, create a new tab or open a new window for rails_driver and run `rails s -p 3001` simultaneously 
10. Visit [localhost:3001](http://localhost:3001) to see the app in action
11. Run `bundle exec rspec` from rails_driver to see the spec harness; there should be 18 passing tests
12. Run `bundle exec rspec` from the rails-engine to see the test suite; there should be 60 passing tests

## Endpoints

### Items
* All items in db: "/api/v1/items"
* Individual item: "/api/v1/items/200"
* Post, get, patch, and destry (CRUD) for items: "/api/v1/items"
* Find merchant owner of specific item: "/api/v1/items/(item id)/merchant"

### Merchants
* All merchants in db: "/api/v1/merchants"
* Individual item: "/api/v1/merchants/200"
* CRUD for merchants: "/api/v1/merchants"
* Find all items for an individual merchant "/api/v1/merchants/(merchant id)/items"

*Searching database with any attributes belonging to merchants or items returns a list of objects that match the query or a single object that matches the query, "/api/vi/merchants/find_all?name=engine" OR "/api/v1/items/find?unit_price=9995".

### Business Intelligence
* Variable number of merchants ranked by total revenue: "/api/v1/merchants/most_revenue?quantity=x"
* Total revenue for a single merchant: "/api/v1/merchants/:id/revenue"
* Total revenue across all merchants between the given dates: "/api/v1/revenue?start=<start_date>&end=<end_date>"
* Variable number of merchants ranked by total number of items sold: "/api/v1/merchants/most_items?quantity=x"

## Statistics

   ![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a) ![](https://img.shields.io/badge/Code-Ruby-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)   ![](https://img.shields.io/badge/Code-SQL-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)

## Schema Design

![Screen Shot 2020-12-18 at 4 17 49 AM](https://user-images.githubusercontent.com/67594471/102609301-78e81c80-40e8-11eb-8b35-0d9e21b8da12.png)
