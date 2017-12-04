# ESaaS Engagements Tracker

The goal of this currently bare-bones app, thrown together by Armando
Fox, is to do continuous tracking over time of customer apps developed
by the "ESaaS ecosystem" around [UC Berkeley CS169 Software
Engineering](https://cs169.saas-class.org).

[![Build Status](https://travis-ci.org/csungwon/esaas-engagements.svg?branch=master)](https://travis-ci.org/csungwon/esaas-engagements)
[![Maintainability](https://api.codeclimate.com/v1/badges/37b99accaeddb85c2528/maintainability)](https://codeclimate.com/github/csungwon/esaas-engagements/maintainability)
[![Test Coverage](https://codeclimate.com/github/csungwon/esaas-engagements/badges/coverage.svg)](https://codeclimate.com/github/csungwon/esaas-engagements/coverage)

[Pivotal Tracker](https://www.pivotaltracker.com/n/projects/2070245)
[Heroku Deployment](https://shielded-bastion-61752.herokuapp.com/)

The data currently populating the app came from this [Google spreadsheet](https://docs.google.com/spreadsheets/d/1FnllGoYuUjhdF1xF1kQRIrWrv_znxqokSq84-uNw8wY/edit#gid=0).

Since we have had many repeat customers who come back in subsequent
semesters to have a new student cohort enhance an existing app, this
system will track an app's current status over its lifetime as it is
handed off from cohort to cohort.

The main models are:

* App: a deployable Web app.  An app's status may be:
  * `Dead`: not deployed, and/or customer not actively using; dormant
  * `Development`: in active development (a team is working on it right now), whether or not deployed in production
  * `In use`: in production use at a customer site; customer has not expressed interest in further improvements
  * `In use and wants improvement`: in production, and customer is interested in further development
  * `Inactive but wants improvement`: an app whose current state isn't functional enough for customer to use yet, but customer is interested in further development to make app useful
  * `Pending`: a customer has suggested an app they want built or improved, but a coach/instructor hasn't yet vetted whether it's a good fit for some student team
* Org: a customer organization for whom the app was developed
* User: various subcategories, including developer (e.g. student), coach
(mentor, GSI), customer contact.  Also a principal for authentication: as of now, only a staff member has authorization to edit/destroy.
* Coaching org: an "organization" whose main function is to provide
mentoring/coaching to students building apps.  E.g., "UCB CS169 Fall 17"
is an org, as is "[AgileVentures](https://agileventures.org)", and so
on.  I would propose that each offering of CS169 be its own org, so we
can track engagements accurately.

An `engagement` is a period of time over which a coach interacts with
developer(s) to work on an app.  During that time, the app is in
`development` status. After the engagement ends, the app is either in `In use` status
(customer is using it; app may be enhanced in future) or `dead`
(customer not using it, because it doesn't meet their needs enough to be
usable).

At any given time every app is always part of an engagement, so
engagements have a start date but no end date; an engagement ends when
the app transitions into another engagement.

So for example, an app that is developed in Spring 2017, used by the
customer over the summer, and picked up by another cohort for
enhancements in Fall 2017, might have these engagements:

| Status      | Start date | Coaching org  | Coach      |
|:----------: | :-:        | :-:           | :-:        |
| development | 1/15/2017  | CS169 S'17    | Tony Lee   |
| maintenance | 5/5/2017   | AgileVentures | Sam Joseph |
| development | 8/23/2017  | CS169 F'17    | An Ju      |

# Why ESaaS Engagement Tracker?

The goal is to have a robust ecosystem that eventually encompasses not
only UCB CS169 but its offshoots: the AgileVentures volunteer-developer
corps, ESaaS-like courses at other schools (Texas A&M now emulates UCB's
approach and builds software for local nonprofits), etc.

When a new course offering starts, or when a non-course org is looking
to source projects, they can look here to find apps in need of
enhancement; if greenfield apps are built, they can be registered here
so that future dev teams can pick up and enhance them.

# Getting the app running locally

You will need Ruby 2.2.5 and Rails 4.2.6 installed.

Clone the repo, and run `rake db:setup` and then `rake db:seed` to
seed the development database with a subset of the initial data set.
You should then be able to use `rails server` to start the app, and
point your browser at `http://localhost:3000` to access it.

## Logging In (Production)

In production, you login with your GitHub account.  Login is only
permitted for a user whose `github_uid` field in the database is set to
their GitHub username, e.g. `armandofox`.  So, **get someone who already
has this field set to set the field for your user record.**

## Logging In (Development)

The file `db/github_mock_login.yml` contains the attributes for a fake
user that you can login-as for development work.  You will always be
logged in as the user whose info appears in this file.  **Important:**
You must have run `rake db:seed` to create the fake orgs, apps, and this
user.

The file `config/application.yml.asc` is an encrypted version of the
file containing the GitHub application key and secret for OmniAuth.
You shouldn't need to change it, but if you do, get the encryption key
from @armandofox so that you can decrypt, modify, then re-encrypt and
commit `application.yml.asc`.

If you want to have GitHub OAuth on the development environment or on the heroku
deployment environment, you have to register your app [here](https://github.com/settings/applications/new). After you register and obtain Client ID and Client Secret, add
the keys to `config/application.yml`

## Setting Environment Variables

We used `figaro` gem to upload app environment variables. You can add secret keys
in `config/application.yml`. **Important**: since you are storing security-sensitive
information, remember to add this file to `.gitignore`. The following keys are
needed to correctly run the app:

* `secret_key_base`: this is used to encrypt and sign session in order to safely
send session back and forth in cookies
* `github_key`, `github_secret`: these are used for login with GitHub

Although the app mocks the GitHub OAuth mechanism for test and development environment,
you still need to add a "mock key" to `config/applicaiton.yml`. For example:

```yaml
test:
  secret_key_base: test
  github_key: test
  github_secret: test

development:
  secret_key_base: development
  github_key: development
  github_secret: development
```

However, we think it is a good practice to have a mock key that resembles a real
key. You can easily generate a key using `rake secret`.

To upload the keys to a Heroku app, run `figaro heroku:set -e production`.

After setting environment variables using `figaro`, you can access them by
`ENV["YOURKEY"]` or `Figaro.env.YOURKEY`. Refer the [documentation](https://github.com/laserlemon/figaro) for more information.

## Uploading Images with AWS S3
Since Heroku wipes out all data when dyno server is down, we used AWS S3 Bucket
to store the images. After you open an account for AWS, you will need the following
keys (in `config/application.yml`):
```yaml
AWS_ACCESS_KEY_ID: <your_aws_access_key_id>
AWS_SECRET_ACCESS_KEY: <your_aws_secret_access_key>
S3_BUCKET_NAME: <your_s3_bucket_name>
AWS_REGION: <your_aws_region>
S3_HOST_NAME: <your_s3_host_name>
```

## Running Unit/Integration Tests

We used Cucumber/Capybara for integration tests, and RSpec for unit tests. You can
run tests using:
```shell
bundle exec cucumber
bundle exec rspec
```

To test javascript behaviors, Cucumber uses Selenium Webdriver as default. This
requires you to have a [geckodriver](https://github.com/mozilla/geckodriver/releases),
and firefox browser. If you want to use other drivers (e.g. [chromedriver](https://sites.google.com/a/chromium.org/chromedriver/)) refer to [Capybara](https://github.com/teamcapybara/capybara) webpage
to configure default webdriver.

If you do not want to download a new webdriver, you can skip scenarios which require
webdriver by:
```shell
bundle exec cucumber --tags ~@javascript
```

# FA17 Engagement: Main Features

* New `App`, `Org`, and `User` can be created all at once, with proper association
* Every user can "post" comments on an `App`, `Org`, and `User`
  - `App` has different types of comments
  - Any class that inherits `Commentable` can have many comments
* More comprehensive customer feedback through a feedback form with ratings/comments
* Aggregates customer feedbacks from all iterations of an engagement, and display
averages on each category
* `User` supports different typs (e.g. Student, Staff/Coach, Customer)
* Exports `Engagement` information as a CSV file
* each `User` contains a profile image
  - we are using Amazon S3 to store images on production envrionment, because
  Heroku has [emphemeral filesystem](https://devcenter.heroku.com/articles/dynos#ephemeral-filesystem). If you want to run this app on heroku server, you will
  have to create another Amazon S3 account and setup the configuration([Instruction](https://devcenter.heroku.com/articles/paperclip-s3)).
* Authorization to edit/destroy only to "Coach"
* Autocomplete dropdown list (select2)
* Major Bootstrap styling

# High priority feature list

0. Add user contact info and a way to track user meeting notes
0. Google or Facebook or LinkedIn login for customer contacts
0. Manage customer feedback as a active record, not a json string
0. Add multiple user types (e.g. CS169 staff can be both a coach and a client)
0. Mailing customer feedback forms to customers for each iteration (Sendgrid)
0. More authorizations to different types of users
  - a user cannot edit/delete other users unless it is a staff/coach