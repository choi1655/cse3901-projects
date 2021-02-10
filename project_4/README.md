# Project 4
## Environment Setup
#### Initial Setup Instructions:
To download the proper gems and create the right routes to the database, the user must first execute:

`$ bundle install`
`$ yarn install--check-files`
`$ rails db:migrate`

#### Data Scraping
The following three commands must be executed after:

`$ rails runner 'AdminHelper.scrape_courses'`

This creates an admin account for the project_4 database
`$ rails runner 'AdminHelper.createAdminUser("username","password")'`

`$ rails runner 'AdminHelper.scrape_classes(semester#)'`

Replace semester# with the 4-digit code:
first three digits = calendar year-1900
4th digit = 0/winter (quarters only), 2/spring, 4/summer, 8/autumn
e.g. Autumn 2012 is 2012-1900 = 112 & 8 --> 1128.

Example: To fetch courses from Fall 2020, use the following command:

`$ rails runner 'AdminHelper.scrape_classes(1208)'`

#### Example of full set of commands
`$ bundle install`
`$ yarn install--check-files`
`$ rails db:migrate`
`$ rails runner 'AdminHelper.scrape_courses'`
`$ rails runner 'AdminHelper.scrape_classes(1208)'`

#### Running App

`$ rails server`

A local virtual server will be generated and the the user can then open their browser of choice and in the address space of the browser they must enter:

`127.0.0.1:3000/`

Upon successful connection to the virtual serever through the browser, the user will then be able to access the home portal.


## User Interfaces

#### Createing admin account
To create a new admin account:
`'AdminHelper.createAdminUser("username","password")'`

(replace username/password fields if needed)

#### Creating new account (student/instructor):
The user must select an application for student or instructor. Students and instructors will then be verified that they are part of the Ohio State database through the OSU find people system and students will recieve an email with their OSU affiliated email containing a password. Instructors must first be verified by an admin. Once a user has access to the project_4 app, they will be able to navigate their specific views.

#### Logging In:
After creating a new login, the user will be directed to a login page or the user can select the login button from the homepage. The user must enter their username and password. The username and password will then be verified that they match with what is in the database. If there is a match, the user will then have access to the database. 

#### Changing Passwords:
After a user has access to the project_4 application, they will have to option to change their passwords on demand. In order to do so, they must know the password currently in the database and provide a new password to replace it. The passwords must be at least 6 characters in length and may not be the same password in the database currently.

#### Logging Out:
A user simply needs to just select the logout button being displayed across all views and the users session will then be terminated taking them back to the home page portal.

## Code Architecture: 

### Interfaces:

#### Student Interface

Once they have been verified, gotten their password from their email, and logged in, students are be able to view their applications, select classes they are interested in grading, specify CSE courses they took/are taking, edit their schedule, upload resume and advising report, and submit/update applications.  They also can change their password at any point.

#### Instructor Interface

Once instructors have been verified by an admin and have logged in, instructors are be able to view applications submitted to their sections and make recommendations for admins to consider when making decisions on applications.

#### Admin Interface

Admins are able to view applications from students, make hiring decisions, view recommendations from instructors, approve instructors, and edit instructor/class table.

### Models:

#### Users

User information needed to navigated through the project_4 application and access based upon permissions.

#### Profiles

A user is verified by scraping the OSU find people by their vcard and their information and is added to the project_4 database
https://www.osu.edu/findpeople/name.#/vcard

#### Classes

OSU classes and and time availabilities are scraped from the project 4 database.
https://www.asc.ohio-state.edu/barrett.3/schedule/CSE/

#### Courses:

OSU courses are to be scraped from the coe-portal and course information is taken and stored in the project_4 database.
http://coe-portal.cse.ohio-state.edu/pdf-exports/CSE/

#### Applications

Submitted by applicants in .PDF format interested in seeking employment at OSU as a grader. 

## References:

* The login and create new users model/view/controller inspiration used from:
    * Source: https://hackernoon.com/authentication-and-authorization-with-bcrypt-in-rails-mw1g3u3l
    * Source: https://medium.com/@wintermeyer/authentication-from-scratch-with-rails-5-2-92d8676f6836
    * Source: https://guides.rubyonrails.org/action_mailer_basics.html

* The data source for student user validaion and profile information:
    * Source: https://www.osu.edu/findpeople/name.#/vcard

* The data source used for scraping and to display after user login:
    * Source: https://www.asc.ohio-state.edu/barrett.3/schedule/CSE/
	
* The data source user for getting cse courses information:
    * Source: http://coe-portal.cse.ohio-state.edu/pdf-exports/CSE/

## Admin Interface Team:
* Nawras Alnaasan.1
* Dominik Winecki.1

## Instructor/Student Interface Team:
* John Choi.1655
* Haoran (Randall) Jiang.1818

## Authorizations/Login Team:
* Alec Juergens.27
* Mike McDaniel.619
