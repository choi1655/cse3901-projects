# Project 3

## Setup Instructions:

#### Initial Setup
To download the proper gems and create the right routes to the database, the user must first execute:

`$ bundle install`
`$ rails db:migrate`

#### Data Scraping
The following two commands must be executed after:

`$ rails runner 'Course.scrape(semester#)'`

Replace semester# with the 4-digit code:
first three digits = calendar year-1900
4th digit = 0/winter (quarters only), 2/spring, 4/summer, 8/autumn
e.g. Autumn 2012 is 2012-1900 = 112 & 8 --> 1128.

Example: To fetch courses from Fall 2020, use the following command:

`$ rails runner 'Course.scrape(1208)'`

#### Running App

`$ rails server`

A local virtual server will be generated and the the user can then open their browser of choice and in the address space of the browser they must enter:

`127.0.0.1:3000/`

Upon successful connection to the virtual serever through the browser, the user will then be able to access the login portal.

#### Creating New Login:
The user has must select the Sign Up option to create a new user. They will then be prompted to enter their username and their password twice to confirm that it matches. The username and password must be bewteen 8 and 22 characters in length to be valid. Upon completion a new user will be created to acess the database information.

#### Logging In:
The user must select either Log In or Login Page. After they will be taken to the login page and must enter their username and password. The username and password will then be verified that they match with what is on the database. If there is a match, the user will then have access to the database. 

#### Interpreting Information:
Once a user has access to the database with user logon capabilities, they will be able to access the course information taken from the Ohio State website and stored into the database. Users will be able to view the most current and up-to-date scheduling.

## Code Architecture 

### Course Model:

#### Web-Scraper/Model

The web-scraper is used to gather data from an Ohio State University list of current class schedules and store it into a database that has user login access to view these results at anytime.

#### Views/Controller

The .css styles used are meant to enchance the users experience by applying vivid colors and organizing data to display in a readable manner.

#### Filtering

Filtering is done at the model level depending on the params passed by the user via the view. Only data that matches the filter criteria is fetched from the database.

### Login Model:

The login interface is used to handle all user login and new user request. The user and their information are then stored into a database. The two main components of this model is used for creating a new user and validating current users can access the database of information.

## References:

* The login and create new users model/view/controller inspiration used from:
    * Source: https://hackernoon.com/authentication-and-authorization-with-bcrypt-in-rails-mw1g3u3l
    * Source: https://medium.com/@wintermeyer/authentication-from-scratch-with-rails-5-2-92d8676f6836

* The data source used for scraping and to display after user login:
	* Source: https://www.asc.ohio-state.edu/barrett.3/schedule/CSE/

## Model Team:
* Nawras Alnaasan.1
* Dominik Winecki.1

## View Team:
* John Choi.1655
* Haoran (Randall) Jiang.1818

## Login Team:
* Alec Juergens.27
* Mike McDaniel.619
