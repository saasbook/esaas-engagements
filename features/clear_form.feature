@wip
Feature: Users can reset any form

	As a user who fills out the forms
	So that I can reset the form
	I want to add a reset button in each form

Background: Logged in
	Given the following users exist:
	  | name            | github_uid      | email                         |
	  | ESaaS Developer | esaas_developer | esaas_developer@saasbook.info |
	  | Armando Fox     | armandofox      | armandofox@berkeley.edu       |
	  | Adnan Hemani    | adnanhemani     | adnanhemani@berkeley.edu      |

	And the following apps exist:
	  | name                     | description  | org_id | status  |
	  | AFX Dance                | Awesome!     | 3      | pending |
	  | Go Bird                  | Great!       | 1      | pending |
	  | ESaaS Engagement Tracker | The Best App | 2      | pending |

	And the following orgs exist:
	  | name                         | contact_id |
	  | Berkeley Student Cooperative | 1          |
	  | UC Berkeley CS169            | 2          |
	  | Armando's Secret Society     | 2          |
	  | Bachelor Party with Adnan    | 3          |

	And the following engagements exist:
	  | app_id | coaching_org_id | coach_id | team_number | start_date | student_names     |
	  | 1      | 1               | 1        | 13          | 2012-03-13 | a, b, c           |
	  | 3      | 2               | 1        | 20          | 2017-09-15 | SC,JD,KH,DK,JS,KP |

	And the following iterations exist:
	  | engagement_id | end_date   |
	  | 1             | 2012-05-23 |
	  | 2             | 2017-11-27 |

	And I am logged in

# Story ID: 153070009
@javascript
Scenario: user can reset a form for New App
	Given I am on the Apps page
	When I follow "New App"
	And I fill in "App Name" with "myNewApp"
	And I fill in "App Description" with "this app is awesome"
	And I fill in "Deployment url" with "mynewapp.com"
	And I fill in "Repository url" with "github.com/mynewapp"
	And I fill in "Code climate url" with "codeclimate.com/mynewapp"
	And I select "Berkeley Student Cooperative" from "Org"
	And I select "Dead" from "Status"
	And I press "Reset"
	Then All text fields are empty for the form with selector ".new_app"
	And I should have selected "Armando's Secret Society" from "Org"
	And I should have selected "Pending" from "Status"

# Story ID: 153070009
@javascript
Scenario: user can reset a form for New Organization
	Given I am on the Orgs page
	When I follow "New Org"
	And I fill in "Org Name" with "myNewOrg"
	And I fill in "Address line 1" with "123 esaas street"
	And I fill in "Address line 2" with "#789"
	And I fill in "City state zip" with "Berkeley, CA 90000"
	And I fill in "Phone" with "123123123"
	And I fill in "Description" with "this is my new org"
	And I fill in "Url" with "myneworg.com"
	And I select "ESaaS Developer" from "Org"
	And I check "Defunct"
	And I press "Reset"
	Then All text fields are empty for the form with selector ".new_org"
	And the "Defunct" checkbox should not be checked
	And I should have selected "Adnan Hemani" from "Contact"

# Story ID: 153070009
@javascript
Scenario: user can reset a form for New User
	Given I am on the Users page
	When I follow "New User"
	And I fill in "User Name" with "user"
	And I fill in "User E-mail address" with "user@user.com"
	And I fill in "Preferred contact" with "1234567890"
	And I fill in "Github uid" with "dave_id"
	And I select "Staff" from "Type of user"
	And I fill in "SID" with "123123123"
	And I press "Reset"
	Then All text fields are empty for the form with selector ".new_user"
	And I should have selected "Student" from "Type of user"

# Story ID: 153070009
@javascript
Scenario: user can reset a form for Create New User, Org, and App
	Given I am on the create page
	When I fill in "User Name" with "user"
	And I fill in "Email" with "user@user.com"
	And I fill in "Preferred Contact" with "1234567890"
	And I fill in "Github uid" with "dave_id"
	And I select "Staff" from "Type of User"
	And I fill in "SID" with "123123123"
	And I fill in "Organization Name" with "myNewOrg"
	And I fill in "Address Line 1" with "123 esaas street"
	And I fill in "Address Line 2" with "#789"
	And I fill in "City State Zip" with "Berkeley, CA 90000"
	And I fill in "Phone" with "123123123"
	And I fill in "Organization Description" with "this is my new org"
	And I fill in "url" with "myneworg.com"
	And I check "Defunct"
	And I fill in "App Name" with "myNewApp"
	And I fill in "App Description" with "this app is awesome"
	And I fill in "Deployment url" with "mynewapp.com"
	And I fill in "Repository url" with "github.com/mynewapp"
	And I fill in "Code Climate url" with "codeclimate.com/mynewapp"
	And I press "Reset"
	Then All text fields are empty for the form with selector "#create"
	And I should have selected "Student" from "Type of user"
	And the "Defunct" checkbox should not be checked

# Story ID: 153070009
@javascript
Scenario: user can reset a form for New Engagement
	Given I am on the Apps page
	And the time is "2012-07-16"
	And I follow "AFX Dance"
	And I follow "New Engagement"
	When I fill in "2012-11-13" for "Start date"
	And I select "Berkeley Student Cooperative" from "Coaching org"
	And I select "ESaaS Developer" from "Coach"
	And I select "ESaaS Developer" from "Contact"
	And I fill in "3" for "Team number"
	And I fill in "A,B,C" for "Student names"
	And I fill in "youtube.com" for "Screencast url"
	And I fill in "instagram.com" for "Screenshot url"
	And I fill in "google.com" for "Poster url"
	And I fill in "x.com" for "Presentation url"
	And I fill in "y.com" for "Prototype deployment url"
	And I fill in "z.com" for "Repository url"
	And I press "Reset"
	Then All text fields are empty for the form with selector "#new_engagement"
	And I should have filled in "2012-07-16" for "Start date"
	And I should have selected "Armando's Secret Society" from "Coaching Org"
	And I should have selected "Adnan Hemani" from "Coach"
	And I should have selected "Adnan Hemani" from "Contact"

# Story ID: 153070009
@javascript
Scenario: user can reset a form for New Iteration
	Given the time is "2012-07-13"
	And I am on the Apps page
	And I follow "AFX Dance"
	And I follow "2012-03-13"
	And I follow "Add Iteration..."
	When I fill in "End date" with "2012-04-15"
	And I fill in "Customer feedback" with "This is a general comment"
	And I press "Reset"
	Then All text fields are empty for the form with selector "#new_iteration"
	And I should have selected "2012-07-13" from "End date"

# Story ID: 153070009
@javascript
Scenario: user can reset a form for Edit App
	Given I am on the Apps page
	And I follow "AFX Dance"
	And I follow "Edit App"
	When I fill in "Some random app" for "App Name"
	And I fill in "random description" for "Description"
	And I select "Berkeley Student Cooperative" from "Org"
	And I select "In use" from "Status"
	And I press "Reset"
	Then I should have filled in "AFX Dance" for "App Name"
	And I should have filled in "Awesome!" for "Description"
	And I should have selected "Armando's Secret Society" from "Org"
	And I should have selected "Pending" from "Status"

# Story ID: 153070009
@javascript
Scenario: user can reset a form for Edit Org
	Given I am on the Orgs page
	And I follow "Berkeley Student Cooperative"
	And I follow "Edit Org"
	When I fill in "2012 Larkey Lane" for "Address line 1"
	And I fill in "923-128-1232" for "Phone"
	And I fill in "description for this app" for "Description"
	And I check "Defunct"
	And I follow "Reset"
	Then I should have filled in "Berkeley Student Cooperative" for "Org Name"
	And I should have selected "Adnan Hemani" from "Coach"
	And I should have selected "Adnan Hemani" from "Contact"

# Story ID: 153070009
@javascript
Scenario: user can reset a form for Edit User
	Given I am on the Users page
	And I follow "Armando Fox"
	And I follow "Edit User"
	When I fill in "User Name" with "Fox Armando"
	And I fill in "User E-mail address" with "afox@berkeley.edu"
	And I fill in "Github uid" with "afox"
	And I select "Staff" from "Type of user"
	And I press "Reset"
	Then I should have filled in "Armando Fox" for "User Name"
	And I should have filled in "armandofox@berkeley.edu" for "User E-mail address"
	And I should have filled in "armandofox" for "Github uid"
	And I should have selected "Student" from "Type of user"

# Story ID: 153070009
@javascript
Scenario: user can reset a form for Edit Engagement
	Given I am on the Apps page
	And I follow "AFX Dance"
	And I follow "2012-03-13"
	And I follow "Edit" within "tbody"
	When I fill in "Start date" with "2013-12-23"
	And I select "UC Berkeley CS169" from "Coaching org"
	And I select "Adnan Hemani" from "Coach"
	And I select "Bachelor Party with Adnan" from "Contact"
	And I fill in "Team number" with "2223"
	And I fill in "Student names" with "s1, s2, s3"
	And I press "Reset"
	Then I should have filled in "2012-03-13" for "Start date"
	And I should have selected "Berkeley Student Cooperative" from "Coaching org"
	And I should have selected "ESaaS Developer" from "Coach"
	And I should have selected "Adnan Hemani" from "Contact"
	And I should have filled in "13" for "Team number"
	And I should have filled in "a, b, c" for "Student names"

# Story ID: 153070009
@javascript
Scenario: user can reset a form for Edit Iteration
	Given I am on the the Apps page
	And I follow "ESaaS Engagement Tracker"
	And I follow "2017-09-15"
	And I follow "Edit"
	When I fill in "2016-08-15" for "End date:"
	And I select "1 hour 15 min" from "Duration:"
	And I select "Mostly disagree" from "Demeanor:"
	And I select "Mostly agree" from "Engaged:"
	And I fill in "some comment" for "Engagment comments:"
	And I select "Neither agree nor disagree" from "Communication:"
	And I fill in "some comment" for "Communication comments:"
	And I select "Strongly agree" from "Understanding:"
	And I fill in "some comment" for "Understanding comments:"
	And I select "Strongly disagree" from "Effectiveness:"
	And I fill in "some comment" for "Effectiveness comments:"
	And I select "Mostly disagree" from "Satisfied:"
	And I fill in "some comment" for "Satisfied comments:"
	And I press "reset"
	Then I should have filled in "2017-09-15" for "End date:"
	And I should have selected "15 min" from "Duration:"
	And I should have selected "Strongly agree" from "Demeanor:"
	And I should have selected "Strongly agree" from "Engaged:"
	And I should have selected "Strongly agree" from "Communication:"
	And I should have selected "Strongly agree" from "Understanding:"
	And I should have selected "Strongly agree" from "Demeanor:"
	And I should have selected "Strongly agree" from "Effectiveness:"
	And I should have selected "Strongly agree" from "Satisfied:"
	And All text fields are empty for the form with selector ".edit_iteration"