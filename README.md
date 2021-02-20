# ESaaS Engagements Tracker

[![Build Status](https://travis-ci.org/zfred219/esaas-engagements.svg?branch=master)](https://travis-ci.org/zfred219/esaas-engagements)
[![Maintainability](https://api.codeclimate.com/v1/badges/4f34f3ba42625e63922e/maintainability)](https://codeclimate.com/github/zfred219/esaas-engagements/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/4f34f3ba42625e63922e/test_coverage)](https://codeclimate.com/github/zfred219/esaas-engagements/test_coverage)
[![Bluejay Dashboard](https://img.shields.io/badge/Bluejay-Dashboard_8-blue.svg)](http://dashboard.bluejay.governify.io/dashboard/script/dashboardLoader.js?dashboardURL=https://reporter.bluejay.governify.io/api/v4/dashboards/tpa-CS169L-GH-zfred219_esaas-engagements/main)
[![Known Vulnerabilities](https://snyk.io/test/github/jaspak/esaas-engagements/badge.svg)](https://snyk.io/test/github/jaspak/esaas-engagements)
[<img src="assets/pivotal_tracker_logo.png">](https://www.pivotaltracker.com/n/projects/2070245) 

[Heroku Deployment](https://esaas-team8.herokuapp.com/)

The goal of this currently bare-bones app, thrown together by Armando
Fox with contributions by [Andrew Halle](https://github.com/andrewhalle),
is to enable continuous tracking over time of customer apps developed
by the "ESaaS ecosystem" around [UC Berkeley CS169 Software
Engineering](https://cs169.saas-class.org).

The data initially used to populate the app came from this [Google spreadsheet](https://docs.google.com/spreadsheets/d/1FnllGoYuUjhdF1xF1kQRIrWrv_znxqokSq84-uNw8wY/edit#gid=0).

Since we have had many repeat customers who come back in subsequent
semesters to have a new student cohort enhance an existing app, this
system will track an app's current status over its lifetime as it is
handed off from cohort to cohort.

The main models are:

* App: a deployable Web app, i.e. a student project.  App statuses can fall into two categories:
  1. Deployment statuses:
     * `dead`: Not deployed, and/or customer not actively using;  dormant
     * `development`: In active development (a team is working on it right now), whether or not deployed in
     production
     * `In use`: In production use at a customer site; customer has not expressed interest in further improvements
     * `In use and wants improvements`: In production, and customer is interested in further development
     * `Inactive but wants improvement`: An app whose current state isn't functional enough for customer to use yet, but customer is interested in further development to make app useful
     * `Pending` (deprecated): a customer has suggested an app they want built or improved, but a coach/instructor hasn't yet vetted whether it's a good fit for some student team. **This has been replaced by the vetting statuses mentioned below. DO NOT use it anymore**
  2. Vetting statuses:
     * `Vetting`: Pending (not yet vetted)
     * `On Hold`: We need something from customer during vetting phase
     * `Staff Approved`: Approved by the faculty during vetting phase
     * `Customer Informed`: Staff has approved the project and we’ve informed the customer about acceptance and are waiting for them to confirm whether they meet our customer expectations
     * `Customer Confirmation Received`: Customer has confirmed to meet our expectations
     * `Declined by Staff`: Project declined by staff during vetting
     * `Declined by Customer`: Engagement declined by the customer after we accepted the project
     * `Declined by Customer – Available Next Semester`: Customer is not available this semester but will be available for next semester
     * `Backup`: We are saving this project as a backup in case a client drops
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

You will need Ruby 2.3.1 and Rails 4.2.7 installed.

Clone the repo, and run `rake db:setup` and then `rake db:seed` to
seed the development database with a subset of the initial data set.
You should then be able to use `rails server` to start the app, and
point your browser at `http://localhost:3000` to access it.

## Logging In (Production)

In production, you login with your GitHub account.  Login is only
permitted for a user whose `github_uid` field in the database is set to
their GitHub username, e.g. `armandofox`.  So, **get someone who already
has this field set to set the field for your user record.**

You also need to be a `coach` to navigate through the app and do some core operations
(create, update, delete). In order to give permission at database level run rails
console on heroku server(`heroku run rails console`) and create/update a user:

```ruby
User.create(name: 'USERNAME', email: 'USER@NAME.COM', github_uid: 'username', user_type: 'coach')
```

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
the keys to `config/application.yml`. Make sure you set the authorization callback URL to `<homepage-url>/auth/github/callback`

## Setting Environment Variables

There are two options on how to setup environment variables for local and remote development.

1. You can manually create the `config/application.yml` as listed in the steps below or
2. You could use the `rails g config` as listed in the steps in the [INSTALL.md](INSTALL.md) file.

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

## Email Configuration

To enable email delivery functionality, technically you can use any third-party email delivery service as you wish. But the easiest way in this app is to register and use a [Sendgrid](https://sendgrid.com/) API key by setting

```yaml
SENDGRID_API_KEY: <your_sendgrid_api_key>
```

in `config/application.yml`

For local testing purpose, this is also acceptable:

```zsh
export SENDGRID_API_KEY='<your_sendgrid_api_key>'
```

 in your favorite shell.

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
and Firefox browser. If you want to use other drivers (e.g. [chromedriver](https://sites.google.com/a/chromium.org/chromedriver/)) refer to [Capybara](https://github.com/teamcapybara/capybara) webpage
to configure default webdriver.

If you do not want to download a new webdriver, you can skip scenarios which require
webdriver by:

```shell
bundle exec cucumber --tags ~@javascript
```

# FA17 Engagement: Main Features

* New `App`, `Org`, and `User` can be created all at once, with proper association
* Every user can "post" comments on an `App`, `Org`, and `User`
  + `App` has different types of comments
  + Any class that inherits `Commentable` can have many comments
* More comprehensive customer feedback through a feedback form with ratings/comments
* Aggregates customer feedbacks from all iterations of an engagement, and display
averages on each category
* `User` supports different types (e.g. Student, Staff/Coach, Customer)
* Exports `Engagement` information as a CSV file
* each `User` contains a profile image
  + we are using Amazon S3 to store images on production environment, because
  Heroku has [ephemeral filesystem](https://devcenter.heroku.com/articles/dynos#ephemeral-filesystem). If you want to run this app on heroku server, you will
  have to create another Amazon S3 account and setup the configuration([Instruction](https://devcenter.heroku.com/articles/paperclip-s3)).
* Authorization to edit/destroy only to "Coach"
* Autocomplete dropdown list (select2)
* Major Bootstrap styling

# SP19 Engagement: Main Features

* 9 vetting statuses added to support vetting phase. `pending` should be obsolete
  + Staff can add vetting comments
  + Apps listing page can show only the apps in vetting
  + Repo URL is optional when creating a new app for vetting
* Each `app` has `features` for vetting purpose.
* Each `engagement` has `features` for deployment purpose
* Display app counts per each status on apps listing page
* The ability to "email to organizations" from single point of contact
* Support for rich text editing and display, such as **bold**, *italic* and ordered/unordered listing
* Pagination for `apps`, `Orgs` and `Users`
* Enhanced search bar with checkboxes. Description of each `app` is searchable
* Miscellaneous:
  + Org names and user names are clickable.
  + Clicking `Back` button when editing `app` redirects to the app's show page instead of the apps listing page
  + Move `Edit App` and `Back` buttons to the top right of the page
  + Show `app` status in the app's show page


# FA19 Engagements: Main Features
* Contributors: [Jungwoo Park](https://github.com/jw-park), [Anthony Shao](https://github.com/anthony-repo), [Sabrina Suhair](https://github.com/Sabrina1), [Peter Generao](https://github.com/Autholius), [Alex Mutwiri](https://github.com/bdzr), [King Arthur Alagao](https://github.com/Kialagao)
* Added `My Projects` tab that allows coaches, clients and students who are logged in to see a list of apps registered under their orgs.
* Added functionality to allow logged in users to `request edits` on their projects.
* Added `AppEditRequest` model and migration to support the `request edits` feature above.
* Added 3 `AppEditRequest` statuses: `submitted`, `reviewed` and `resubmitted`.
    + `submitted` edit requests have not yet been approved or reviewed by the staff
    + `reviewed` edit requests  have been reviewed and staff has left feedback but not approved them. Client needs to update the reqeust.
    + `resubmitted` edit requests have been updated and resubmitted by the requester after the coach has left feedback
* Added functionality to show the status of the edit requests on the `GET /app/:id` route that indicates the status of an edit request only to the owner of the app.
* Added `App Edit Request` tab to show list of App Edit requests for the coaches to review.
* Added functionality to review, leave feedback or approve edit request from the coaches' end.
* Added a rails config generator in `lib/generators/config` to allow developers to more easily setup the application locally.
* Added `INSTALL.md` with instructions on how to setup the application both locally and on heroku.
* Updated gem version in `Gemfile` and `Gemfile.lock` to fix security issues with obsolete packages.
* Changed the `Iteration` feature to allow coaches to request iteration feedback directly from a project page.
* Added `Login` button on the toolbar for easier access to the login page
* Changed default bootstrap color schemes and added various labels/tags to make the webpage more accessible
* Added notification features for both `coach` and `client`:
    + Coach: A badge next to the `App Edit Requests` tab, showing the number of `submitted` and `resubmitted` requests.
    + Client: Two notification icons on `My Projects` index page, one of which will notify the user when `Iteration` Feedback Form has been requested from a `coach`, and the other when a `coach` has reviewed a request.

# High priority feature list

1. Add user contact info and a way to track user meeting notes
2. Google or Facebook or LinkedIn login for customer contacts
3. ~~Manage customer feedback as a active record, not a json string~~ *(Completed)*
4. ~~Add multiple user types (e.g. CS169 staff can be both a coach and a client)~~ *(Completed)*
5. Mailing customer feedback forms to customers for each iteration (Sendgrid)
6. More authorizations to different types of users
   * A user cannot edit/delete other users unless it is a staff/coach
