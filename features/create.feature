Feature: create a new app, user, and organization all at once

    As an admin user
    So that I can quickly create an app, user, organization
    I want to create everything on one page

Background: Logged in as admin on the create page
    Given I'm logged in on the orgs page
    And I follow "create"

Scenario: An admin user can visit the create tab
    Given I'm logged in on the orgs page
    And I press "create"
    Then I should be on the create page

Scenario: If you're not logged in and you click on the create tab, there should be an option to log in as admin
    Given I am not logged in
    #web_steps.rb already has below step, we just need to ensure the link is called "create"
    And I press "Create"
    Then I should see "Log in with GitHub"

Scenario: User cannot submit if form is blank
    Given the form is "blank"
    And I press "Create"
    Then creation should fail with "Form is incomplete"

Scenario: User cannot submit if form is incomplete
    Given I fill in the following:
      		| User Name        | Faker         |
      		| Org Name         | Fake Org      |
      		| Org url          | sofake.com    |
      		| App Name         | Fake It       |
      		| Repository url   | notreal.com   |
	And I press "Submit"
	Then creation should fail with "Form is incomplete"

Scenario: User can submit successfully if form is complete
	Given I fill in the following:
    	| App Name       		 | Fake app      	        |
    	| App Description        | Fake app description     |
    	| App Deployment url     | Fake app deployment url  |
    	| App Repository url     | Fake app repository      |
    	| App CodeClimate url    | Fake app codeclimate url |
    	| App Status             | Fake app status          |

	    | Org Name       	     | Fake org name            |
    	| Org Address        	 | Fake org address    	    |
    	| Org Phone          	 | Fake org phone 	        |
    	| Org Description        | Fake org description     |
    	| Org url    		     | Fake org url url 	    |
    	| Org defunct            | Fake org defunct         |

        | User Name       	     | Fake user name           |
    	| User Email       	     | Fake email               |

    And I press "Create"
    Then I should be on the app page for the app "fake_app"


Scenario: User cannot submit successfully if the form contains an app, user, or organization already in database

    Given an app exists with the parameters: "AFX Dance, Fake app description, Fake app		 deployment url, Fake app repository, Fake app codeclimate url, Fake app status"

    And I fill in the following:
    	| App Name       		 | AFX Dance 	            |
    	| App Description        | Fake app description     |
    	| App Deployment url     | Fake app deployment url  |
    	| App Repository url     | Fake app repository      |
    	| App CodeClimate url    | Fake app codeclimate url |
    	| App Status             | Fake app status          |

	    | Org Name       	     | AFX Dance                |
    	| Org Address        	 | Fake org address    	    |
    	| Org Phone          	 | Fake org phone 	        |
    	| Org Description        | Fake org description     |
    	| Org url    		     | Fake org url url 	    |
    	| Org defunct            | Fake org defunct         |

        | User Name       	     | Fake user name           |
    	| User Email       	     | Fake email              	|

    And I press "Create"
    Then creation should fail with "Form contains duplicate organization or app"

Scenario: User can clear the form
    Given I fill in "User Name" with "Some Name"
    And I press "Clear"
    Then I should see an empty form
