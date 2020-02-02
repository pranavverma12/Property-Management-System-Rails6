# Tenancy Database

## Description
This project is the starting point to a coding challenge to product an overly simple Property rental/tenancy database tracking system.

This project has been setup with Rails 6.0.2.1 and Ruby 2.6.5

It contains an opinionated config file for Rubocop linter.  It is not compulsory to use, it is only provided as a suggestion.


We have chosen `sqlite` as the database to keep the project easy to run.

If you wish to change to a different database solution or use any other external services to complete the tasks ... please package up the project in a `docker-compose` file so that we can build and run your solution with a single command.

Please ensure you read **Submission Requirements** before starting the tasks.

## Getting Started
1. Fork this git repository
2. If on github.com, invite `@cathal` to the project. If on gitlab.com invite `@cathalbrowne`.


The commands to set up the rails project are pretty much the same for any rails 6 project:
1. `bundle install` - install gems
1. `bundle exec rake db:create` - set up sqlite database
1. `bundle exec rake db:schema:load` - load the database schema into development database
1. `RAILS_ENV=test rake db:schema:load` - load the database schema in test database
1. `bundle exec rake db:seed` - populate database with some test data (running this deletes any existing data)
1. `bundle exec rspec` - run all the tests, so you can get an idea of what is already present in project. (Also early indicator of problems if any of the tests fail. They should all pass at this beginning stage, 216 tests)
1. Rails 6 is packaged with webpacker, so we need to install and run `yarn` before we can start a rails server.


We have set up the project with guard and a simple `Guardfile` for easier test driven development. It is configured to automatically run tests on file changes. It is optional to use it, but we recommend it while writing tests for faster feedback. (note there might be problems with this kind of setup on Windows as it doesn't alert guard to file changes)
* `bundle exec guard`

Lastly, start rails server and login with default user:
* `bundle exec rails s`

 Username: `admin`
 
 Password: `securePassword`


## Submission Requirements
Before submitting please ensure the following commands run without errors:

* `bundle install` - install any gems you have added to the project
* `bundle exec rake db:create` - create a new database
* `bundle exec db:seed` - populate the database with any data you have specified to demo your solution
* `bundle exec rspec` - Run your tests
* `bundle exec rails s` - Start the server so we can demo your solution

As mentioned earlier if you wish to use docker, please ensure the following commands run without errors:
* `docker-compose build`
* `docker-compose run tests bundle exec rspec`
* `docker-compose up`


Also it is very important that we see your git history and your git comments of your solution. We suggest that you fork this git repository and then share your solution git repository when submitting your solution.

## Recommended Editor (just a suggestion, use your preference)

Visual Studio Code with following extensions:
* Rails
* Ruby
* Ruby Solargraph
* ruby-rubocop
* VSCode Ruby
* vscode-gemfile
* Beautify css/sass/scss/less


This project include a vscode config file that will format code on-save using Rubocop.


## Initial Project
This project is a database of properties and tenants managed by a single Property Letting Agent *(the customer)*.

The initial project contains the following data models (including model unit tests):
* User 
  * username
  * password (using bcrypt-ruby & ActiveModel::SecurePassword)
* Property
  * property_name
  * property_address
  * landlord_first_name
  * landlord_last_name
  * landlord_email
* Tenant
  * first_name
  * last_name
  * email

The current features are provided (including controller tests):
* Session creation(login) and session destroy(logout)
* Property list, create, edit, delete
* Tenant list, create, edit, delete

## Tasks
Make your way through as many tasks as can in the timeframe of 2 weeks. Remember the purpose of this coding challenge is to categorise your approach as a software engineer. There is no pass or fail. Get as far as you can through the list during the time frame (we don't want to cost you too much time).

We have included some of the requirements for the tasks explicitly in the description. Other requirements are vaguely *implied* and you will need to read between the lines and determine them yourself (not unlike real world scenario). 

For each task it is expected that sufficient unit tests for models and controllers will be provided. A test driven/behaviour driven approach to testing is preferred. Feature/Integration tests are not required.


1. The starting design of this app was to store `landlord_name` under a `Property`. A customer has requested that they be able to assign multiple properties to a single landlord. Extract the landlord information from the `Property` model and create a new model `Landlord`. A single `Landlord` can own one or more `Property` records. We will also need a way for a logged in user to manage landlords (list, create, edit, delete). The create process for `Property` will need to be refactored to allow user to select a `Landlord`. **Optional Bonus**: A `Property` can belong to one or more `Landlord` records. i.e. one/two/three/four/etc.. landlords can be joint owners of a single property.

2. The customer now wants to create record of when a `tenant` rents a `property`. This is a `Tenancy`. To record a `Tenancy` the user will need to record:
    * The `start_date` of the tenancy. i.e. When does the `Tenant` move in and start paying rent. The rent should be paid on same day every month going forward. e.g. If the `start_date` is the 23rd of January, the next rent needs to be paid on the 23rd of February. ( To keep the exercise simple... just ignore edge cases like 29th, 30th, 31st of a month so we can avoid the months that do not have those dates. )
    * The `security_deposit`. A `security_deposit` is collected, just in case there is damage on the property when the `Tenant` moves out. The deposit will be used to pay for the repairs of any damage. If there is no damage, the `security_deposit` will be refunded to the `Tenant`. Usually this is the same as 1-month's rent but depending on the agreement, it could be more or less.
    * The `monthly_rent`. The amount of rent due every month.
    * The `property` associated with the `Tenancy`. We also need to make sure here that we don't associated the same property with more than one `Tenancy` i.e. we can't rent out the same property twice!
    * The `tenant` that is renting the property. **Optional Bonus**: A `Tenancy` can be associated to one or more `Tenant` records. i.e. two/three/four/five... tenants/people can joint rent a property.

3. The customer wants to advertise available `Property` records with an `advertised_monthly_rent`. Create a list of available `Property` records (i.e. properties that have not been rented out to a `Tenant`) and display the property name and new advertised_rent figure. This page would need to be available to user's who are not logged in, else potential tenants would not be able to find it.

4. The customer wants to check the bank account to see if all the rent has been paid this month for all the `Tenancy` records. Create a page that lists all the rent amount, the expected rent due day and the property name for every `Tenancy` record for the current month. The customer can then manually use this list to compare to their bank account.
   



