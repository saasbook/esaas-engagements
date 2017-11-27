@wip
Feature: when adding a new iteration, the user can add a general feedback
  As a customer of an engagement/iteration
  So that I can fill out a general comment on each iteration before the full/comprehensive customer feedback
  I want to have a general comment section in the customer feedback

Background: user, org, app, and engagement have been added to database
  Given the following users exist:
      | id | name  | github_uid      | email         |
      | 1  | user1 | esaas_developer | test@user.com |
  
  And the following orgs exist:
      | id | name | contact_id |
      | 1  | org1 | 1          |
  
  Given the following apps exist:
      | id | name  | description | org_id | status  |
      | 1  | app1  | test        | 1      | pending |
  
  And the following engagements exist:
      | id | app_id | contact_id | coaching_org_id | coach_id | team_number | start_date | student_names       |
      | 1  | 1      | 1          | 1               | 1        | 1           | 2017-10-01 | fake1, fake2, fake3 |

# Story ID: 153070134
Scenario: I can enter general feedback when creating a new iteration
  Given I am on the engagement iterations page for engagement id "1"
  And I follow "Add iteration..."
  When I fill in "General Feedback" with "blah blah blah"
  And I press "Save"
  Given I am on the engagement iterations page for engagement id "1"
  Then I should see "General Feedback"
  And I should see "blah blah blah"