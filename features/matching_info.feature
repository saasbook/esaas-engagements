Feature: Test Team Info page feature
   As a coach who created matching 1
   I want to go to matching 1 page
   So that I can see all current progress

   Background: Users and apps have been added to database
      Given the following apps exist:
         | name | description | org_id | status  |
         | App1 | test        | 1      | pending |
         | App2 | test        | 1      | pending |
         | App3 | test        | 1      | pending |
         | App4 | test        | 1      | pending |

      And the following users exist:
         | id | name  | github_uid      | email          | user_type |
         | 1  | user1 | esaas_developer | test@user.com  | coach     |
         | 2  | user2 |                 | test1@user.com | student   |
         | 3  | user3 |                 | test2@user.com | student   |
         | 4  | user4 |                 | test3@user.com | student   |

      Given I am on the login page
      And I follow "Log in with GitHub"
      And I visit "/matching"
      Then I want to create matching with "1" engagements
      Then I fill in "Matching Name" with "Matching 1"
      And I select "App1" from "App Names"
      And I fill in "1) Team Number/Name" with "Team1"
      And I select "user1" from "1) Coach"
      And I select "user2" from "1) Students"
      And I press "Submit"
      And I visit "/matching"
      Then I follow "Matching 1"

   @javascript
   Scenario: Coach can see matching info created
      Then I should see "Matching Progress"
      And I should see "user1"
      And I should see "Team1"
      And I should not see "Team2"
      And I should see "user2"
      And I should not see "user3"
      And I should see "0.0%"
      Then I click the delay delete button "Delete"
      Then I should see "Are you sure to delete Team1?"
      And I follow "Delete"
      Then I should see "Engagement deleted."
      Then I visit "/matching"

   @javascript
   Scenario: Coach can edit engagement
      Given I follow "Edit"
      And I wait "1" seconds for animation
      Then I update the engagement
      Then I should see "Engagement updated."
      Then I visit "/matching"

   @javascript
   Scenario: Coach can add engagement after creation
      Then I want to create matching with "1" engagements
      Then I fill in "Matching Name" with "Matching 2"
      And I select "App3" from "App Names"
      And I select "App4" from "App Names"
      And I fill in "1) Team Number/Name" with "T-1"
      And I select "user1" from "1) Coach"
      And I select "user4" from "1) Students"
      And I press "Submit"
      Then I follow "Matching 2"
      Given I follow "Add Engagement"
      And I wait "1" seconds for animation
      Then I should see "Team Number/Name"
      Then I fill in "Team Number/Name" with "Team 3"
      And I select "user1" from "Coach"
      And I select "user3" from "Students"
      Then I add the engagement
      Then I should see "Engagement added."
      Then I visit "/matching"

   @javascript
   Scenario: Coach cannot add engagement more than project number
      Given I follow "Add Engagement"
      And I wait "1" seconds for animation
      Then I should see "Team Number/Name"
      Then I fill in "Team Number/Name" with "Team 2"
      And I select "user1" from "Coach"
      And I select "user3" from "Students"
      Then I add the engagement
      Then I should see "You cannot add more engagements than projects."
      Then I visit "/matching"

   @javascript
   Scenario: Coach can edit project pool
     Given I follow "Edit Projects Pool"
     And I wait "1" seconds for animation
     Then I update the project
     Then I should see "Projects updated."

     Then I follow "Edit Projects Pool"
     And I wait "1" seconds for animation
     Then I remove the project
     Then I update the project
     Then I should see "Number of projects cannot be fewer than engagements."
     Then I visit "/matching"
