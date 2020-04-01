# Project Management System

## Description
This project is to product an overly simple Property rental/tenancy database tracking system.

This project has been setup with Rails 6.0.2.1 and Ruby 2.6.5

It contains an opinionated config file for Rubocop linter.  It is not compulsory to use, it is only provided as a suggestion.

We have chosen `sqlite` as the database to keep the project easy to run.

## Getting Started
1. Fork this git repository

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


## Editor Used

Sublime

This project include a vscode config file that will format code on-save using Rubocop.

## About Database
This project is a database of properties and tenants managed by a single Property Letting Agent *(the customer)*.

The initial project contains the following data models (including model unit tests):
* User 
  * username
  * password (using bcrypt-ruby & ActiveModel::SecurePassword)
* Property
  * property_name
  * property_address
  * tenancy_start_date
  * tenancy_security_deposit
  * tenancy_monthly_rent
* Tenant
  * first_name
  * last_name
  * email
* Property Tenant
  * propert_id
  * tenant_id
* Property Landlord
  * propert_id
  * landlord_id

The current features are provided (including controller tests):
* Session creation(login) and session destroy(logout)
* Property list, create, edit, delete
* Landlord list, create, edit, delete
* Tenant list, create, edit, delete
* Property Landlord create, delete
* Property Tenant create, delete
* User list

## Flow of the Project
1. Multiple properties can be assigned to a single landlord. Landlord information are available in the `Landlord` table and there mapping are stored in 'PropertyLandlord' table. A single `Landlord` can own one or more `Property` records. Moreover, a `Property` can belong to one or more `Landlord` records. i.e. one/two/three/four/etc.. landlords can be joint owners of a single property.

2. Record of when a `tenant` rents a `property`. This is a `Tenancy`. To record a `Tenancy` the user will need to record:
    * The `start_date` of the tenancy. i.e. When does the `Tenant` move in and start paying rent. The rent should be paid on same day every month going forward. e.g. If the `start_date` is the 23rd of January, the next rent needs to be paid on the 23rd of February. ( To keep is simple... I'm ignoring the edge cases like 29th, 30th, 31st of a month so we can avoid the months that do not have those dates. )
    * The `security_deposit`. A `security_deposit` is collected, just in case there is damage on the property when the `Tenant` moves out. The deposit will be used to pay for the repairs of any damage. If there is no damage, the `security_deposit` will be refunded to the `Tenant`. Usually this is the same as 1-month's rent but depending on the agreement, it could be more or less.
    * The `monthly_rent`. The amount of rent due every month.
    * The `property` associated with the `Tenancy`. We also need to make sure here that we don't associated the same property with more than one `Tenancy` i.e. we can't rent out the same property twice!
    * The `tenant` that is renting the property. 
    * Just like landlords `Tenancy` can be associated to one or more `Tenant` records. i.e. two/three/four/five... tenants/people can joint rent a property.

3. To advertise available `Property` records with an `advertised_monthly_rent`. A list of available `Property` records (i.e. properties that have not been rented out to a `Tenant`) are available on `Advertised Monthly Rent` page. It displays the property name and new advertised_rent figure. This page is available to user's who are not logged in this is done so that potential tenants would not miss any information to search for the property.

4. To check the bank account to see if all the rent has been paid this month for all the `Tenancy` records. A page `Tenancy Rent Record` has been created that will lists all the rent amount, the expected rent due day and the property name for every `Tenancy` record for the current month. The customer can then manually use this list to compare to their bank account.
