Feature: User can add a profile picture that shows up in User details page/comments
	As a user of the app
	So that I can easily communicate with other users
	I want to be able to upload a profile picture and see it on the users page

Background:
	Given the following users exist:
		| name            | github_uid      | email                         | user_type |
		| ESaaS Developer | esaas_developer | esaas_developer@saasbook.info | coach     |
		| Armando Fox     | armandofox      | fox@berkeley.edu              | coach     |
		| Adnan Hemani    | adnanhemani     | adnan.h@berkeley.edu          | coach     |

	And the following orgs exist:
		| name                     | contact_id |
		| UC Berkeley CS169        | 3          |
		| Armando's Secret Society | 2          |

	And the following apps exist:
		| name      | description | status  | org_id |
		| AFX Dance | good stuff  | pending | 1      |

	And I am logged in
	And I follow "Users"

# Story ID: 153069541
Scenario: Each user has a default profile image
	When I follow "Armando Fox"
	Then I should find an image with alternate text "Missing thumb"
	When I follow "Users"
	And I follow "Adnan Hemani"
	Then I should find an image with alternate text "Missing thumb"

# Story ID: 153069541
Scenario: Each user can upload a image by local file
	When I follow "Armando Fox"
	And I follow "Edit User"
	Then I should see "Profile Picture"
	When I attach the file "features/upload_files/ArmandoFox.png" to "Profile Picture"
	And I press "Update User"
	And I follow "Armando Fox"
	Then I should find an image with alternate text "Armandofox"

# Story ID: 153069541
Scenario: User can upload a valid image file (happy path)
	When I follow "Armando Fox"
	And I follow "Edit User"
	When I attach the file "features/upload_files/randomImage.gif" to "Profile Picture"
	And I press "Update User"
	And I follow "Armando Fox"
	Then I should find an image with alternate text "Randomimage"

# Story ID: 153069541
Scenario: User cannot upload an invalid image file (sad path)
	When I follow "Armando Fox"
	And I follow "Edit User"
	When I attach the file "features/upload_files/notanimage.txt" to "Profile Picture"
	And I press "Update User"
	Then I should see "Profile picture content type is invalid"

	When I attach the file "features/upload_files/notjsagain.js" to "Profile Picture"
	And I press "Update User"
	Then I should see "Profile picture content type is invalid"

	When I attach the file "features/upload_files/haterspec.rb" to "Profile Picture"
	And I press "Update User"
	Then I should see "Profile picture content type is invalid"

# Story ID: 153069541
Scenario: User profile picture is also shown on comments
	When I follow "ESaaS Developer"
	And I follow "Edit User"
	When I attach the file "features/upload_files/ArmandoFox.png" to "Profile Picture"
	And I press "Update User"
	And I go to the app details page for "AFX Dance"
	When I fill in "Write a comment..." with "AFX Dance is awesome!"
	And I press "Post"
	Then I should find an image with alternate text "Armandofox"
