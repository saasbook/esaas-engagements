@wip
Feature: Users can choose a type of comment on app

	AS a staff that manages the matching between a project and customers
	SO THAT I can easily keep track of an app's progress of customer matching
	I WANT the app page have different comment types not only for general comments, but also for contact progress

Background:
    Given the following apps exist:
		| name  | description | org_id | status  |
		| app1  | test        | 1      | pending |
		| app2  | test        | 1      | pending |
		| app3  | test        | 1      | pending |

	And I am logged in
	And I follow "app1"

# Story ID: 152689457
Scenario: there are different comment types available
	Then I should see "Contact Status"
	And I should see "App Functionality"
	And I should see "General"

# Story ID: 152689457
Scenario: User can edit and choose different comment types
	Given I fill in "Write a comment..." with "This App is AWESOME!"
	And I press "Post"
	When I follow "Edit"
	And I choose "App Functionality"
	And I press "Edit"
	And I uncheck all comment types
	And I check "App Functionality"
	Then I should see "This App is AWESOME!"

# Story ID: 152689457
Scenario: User can group comments by type
	Given the following comments exist:
		| user 			  | body 						| comment_type 		|
		| esaas_developer | add search feature			| App Functionality |
		| armando_fox	  | Contacted AFX Dance Manager | Contact Status 	|
		| adnanhemani	  | I'm still a single!			| General 			|
	When I uncheck all comment types
	Then I should not see any comments
	When I check "App Functionality" within "#select_comment_type"
	Then I should see "add search feature"

	When I uncheck all comment types
	When I check "Contact Status" within "#select_comment_type"
	Then I should see "Contacted AFX Dance Manager"

	When I uncheck all comment types
	When I check "General" within "#select_comment_type"
	Then I should see "I'm still a single!"

	When I uncheck all comment types
	When I check "App Functionality" within "#select_comment_type"
	And I check "General" within "#select_comment_type"
	Then I should see "add search feature"
	And I should see "I'm still a single!"
