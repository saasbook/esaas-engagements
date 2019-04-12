Feature: Users can reset any form

	As a user who fills out the forms
	So that I can reset the form
	I want to add a reset button in each form

Background: Logged in
	Given the following users exist:
	  | name            | github_uid      | email                         | user_type |
	  | ESaaS Developer | esaas_developer | esaas_developer@saasbook.info | coach     |
	  | Armando Fox     | armandofox      | armandofox@berkeley.edu       | coach     |
	  | Adnan Hemani    | adnanhemani     | adnanhemani@berkeley.edu      | coach     |

	And the following apps exist:
	  | name                     | description  | org_id | status  |
	  | AFX Dance                | Awesome!     | 3      | pending |
	  | Go Bird                  | Great!       | 1      | pending |
	  | ESaaS Engagement Tracker | The Best App | 2      | pending |

	And the following orgs exist:
	  | name                         | contact_id |
	  | Berkeley Student Cooperative | 1          |
	  | UC Berkeley CS169            | 2          |
	  | Secret Society by Armando    | 2          |
	  | Bachelor Party with Adnan    | 3          |

	And the following engagements exist:
	  | app_id | coach_id | team_number | start_date | student_names     |
	  | 1      | 1        | 13          | 2012-03-13 | a, b, c           |
	  | 3      | 1        | 20          | 2017-09-15 | SC,JD,KH,DK,JS,KP |

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
	And I fill in "Deployment Url" with "mynewapp.com"
	And I fill in "Repository Url" with "github.com/mynewapp"
	And I fill in "Code Climate Url" with "codeclimate.com/mynewapp"
	And I select "Berkeley Student Cooperative" from "Organization"
	And I select "Dead" from "Status"
	And I press "Reset"
	Then All text fields are empty for the form with selector "#new_app"
	And the "Organization" field should contain "4"
	And the "Status" field should contain "pending"

# Story ID: 153070009
@javascript
Scenario: user can reset a form for New Organization
	Given I am on the Orgs page
	When I follow "New Org"
	And I fill in "Organization Name" with "myNewOrg"
	And I fill in "Address Line 1" with "123 esaas street"
	And I fill in "Address Line 2" with "#789"
	And I fill in "City State Zip" with "Berkeley, CA 90000"
	And I fill in "Phone" with "123123123"
	And I fill in "Description" with "this is my new org"
	And I fill in "Url" with "myneworg.com"
	And I select "ESaaS Developer" from "Contact"
	And I check "Defunct"
	And I press "Reset"
	Then All text fields are empty for the form with selector "#new_org"
	And the "Defunct" should not be checked
	And the "Contact" field should contain "3"

# Story ID: 153070009
@javascript
Scenario: user can reset a form for New User
	Given I am on the Users page
	When I follow "New User"
	And I fill in "User Name" with "user"
	And I fill in "Email" with "user@user.com"
	And I fill in "Preferred Contact" with "1234567890"
	And I fill in "Github Uid" with "dave_id"
	And I select "Coach" from "User Type"
	And I fill in "SID" with "123123123"
	And I press "Reset"
	Then All text fields are empty for the form with selector "#new_user"
	And the "User Type" field should contain "student"

# Story ID: 153070009
@javascript
Scenario: user can reset a form for Create New User, Org, and App
	Given I am on the create page
	When I fill in "User Name" with "user"
	And I fill in "Email" with "user@user.com"
	And I fill in "Preferred Contact" with "1234567890"
	And I fill in "Github Uid" with "dave_id"
	And I select "Coach" from "User Type"
	And I fill in "SID" with "123123123"
	And I fill in "Organization Name" with "myNewOrg"
	And I fill in "Address Line 1" with "123 esaas street"
	And I fill in "Address Line 2" with "#789"
	And I fill in "City State Zip" with "Berkeley, CA 90000"
	And I fill in "Phone" with "123123123"
	And I fill in "Organization Description" with "this is my new org"
	And I fill in "Url" with "myneworg.com"
	And I check "Defunct"
	And I fill in "App Name" with "myNewApp"
	And I fill in "App Description" with "this app is awesome"
	And I fill in "Deployment Url" with "mynewapp.com"
	And I fill in "Repository Url" with "github.com/mynewapp"
	And I fill in "Code Climate Url" with "codeclimate.com/mynewapp"
	And I press "Reset"
	Then All text fields are empty for the form with selector "#create"
	And the "User Type" field should contain "student"
	And the "Defunct" should not be checked

# Story ID: 153070009
@javascript
Scenario: user can reset a form for New Engagement
	Given I am on the Apps page
	And the time is "2012-07-16"
	And I follow "AFX Dance"
	And I follow "New Engagement"
	When I fill in "2012-11-13" for "Start Date"
	And I select "ESaaS Developer" from "Coach"
	And I fill in "3" for "Team Number"
	And I fill in "A,B,C" for "Student Names"
	And I fill in "youtube.com" for "Screencast Url"
	And I fill in "instagram.com" for "Screenshot Url"
	And I fill in "google.com" for "Poster Url"
	And I fill in "x.com" for "Presentation Url"
	And I fill in "y.com" for "Prototype Deployment Url"
	And I fill in "z.com" for "Repository Url"
	And I press "Reset"
	Then All text fields are empty for the form with selector "#new_engagement"
	And I should have filled in "2012-07-16" for "Start Date"
	And the "Coach" field should contain "3"

# Story ID: 153070009
@javascript
Scenario: user can reset a form for New Iteration
	Given the time is "2012-07-13"
	And I am on the Apps page
	And I follow "AFX Dance"
	And I follow "2012-03-13"
	And I follow "Add Iteration..."
	When I fill in "End Date" with "2012-04-15"
	And I fill in "Customer Feedback" with "This is a general comment"
	And I press "Reset"
	Then All text fields are empty for the form with selector "#new_iteration"
	And I should have filled in "2012-07-13" for "End Date"

# Story ID: 153070009
@javascript
Scenario: user can reset a form for Edit App
	Given I am on the Apps page
	And I follow "AFX Dance"
	And I follow "Edit App"
	When I fill in "Some random app" for "App Name"
	And I fill in "random description" for "App Description"
	And I select "Berkeley Student Cooperative" from "Org"
	And I select "In use" from "Status"
	And I press "Reset"
	Then I should have filled in "AFX Dance" for "App Name"
	And I should have filled in "Awesome!" for "App Description"
	And the "Organization" field should contain "3"
	And the "Status" field should contain "pending"

# Story ID: 153070009
@javascript
Scenario: user can reset a form for Edit Org
	Given I am on the Orgs page
	And I follow "Berkeley Student Cooperative"
	And I follow "Edit Org"
	When I fill in "2012 Larkey Lane" for "Address Line 1"
	And I fill in "923-128-1232" for "Phone"
	And I fill in "description for this app" for "Organization Description"
	And I check "Defunct"
	And I press "Reset"
	Then I should have filled in "Berkeley Student Cooperative" for "Organization Name"
	And the "Contact" field should contain "1"

# Story ID: 153070009
@javascript
Scenario: user can reset a form for Edit User
	Given I am on the edit user page for user id: "2"
	When I fill in "User Name" with "Fox Armando"
	And I fill in "Email" with "afox@berkeley.edu"
	And I fill in "Github Uid" with "afox"
	And I select "Coach" from "User Type"
	And I press "Reset"
	Then I should have filled in "Armando Fox" for "User Name"
	And I should have filled in "armandofox@berkeley.edu" for "Email"
	And I should have filled in "armandofox" for "Github Uid"
	And the "User Type" field should contain "coach"

# Story ID: 153070009
@javascript
Scenario: user can reset a form for Edit Engagement
	Given I am on the Apps page
	And I follow "AFX Dance"
	And I follow "Edit"
	When I fill in "Start Date" with "2013-12-23"
	And I select "Adnan Hemani" from "Coach"
	And I fill in "Team Number" with "2223"
	And I fill in "Student Names" with "s1, s2, s3"
	And I press "Reset"
	Then I should have filled in "2012-03-13" for "Start Date"
	And the "Coach" field should contain "1"
	And I should have filled in "13" for "Team Number"
	And I should have filled in "a, b, c" for "Student Names"

# Story ID: 153070009
@javascript
Scenario: user can reset a form for Edit Iteration
	Given I am on the Apps page
	And I follow "ESaaS Engagement Tracker"
	And I follow "2017-09-15"
	And I follow "Edit"
	When I fill in "2016-08-15" for "End Date"
	And I select "1 hour 15 min" from "Duration"
	And I select "Mostly disagree" from "Demeanor"
	And I fill in "some comment" for "Demeanor Comments"
	And I select "Mostly agree" from "Engagement"
	And I fill in "some comment" for "Engagement Comments"
	And I select "Neither agree nor disagree" from "Communication"
	And I fill in "some comment" for "Communication Comments"
	And I select "Strongly agree" from "Understanding"
	And I fill in "some comment" for "Understanding Comments"
	And I select "Strongly disagree" from "Effectiveness"
	And I fill in "some comment" for "Effectiveness Comments"
	And I select "Mostly disagree" from "Satisfaction"
	And I fill in "some comment" for "Satisfaction Comments"
	And I press "Reset"
	Then I should have filled in "2017-11-27" for "End Date"
	And the "Duration" field should contain "15 min"
	And the "Demeanor" field should contain "Strongly agree"
	And the "Engagement" field should contain "Strongly agree"
	And the "Communication" field should contain "Strongly agree"
	And the "Understanding" field should contain "Strongly agree"
	And the "Effectiveness" field should contain "Strongly agree"
	And the "Satisfaction" field should contain "Strongly agree"
	And All text fields are empty for the form with selector "#edit_iteration"