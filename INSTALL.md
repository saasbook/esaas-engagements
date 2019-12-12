# Setup For Localhost Development

## 1. Generate new config files 
The following command makes it easy to get started with the configurations required to run the application.
Run this command in the directory containing the project to generate configs with reasonable defaults:

`rails g config`

This generates the following files:
```markdown
Dockerfile
docker-compose.yml
.esaas-engagements-config.json
config/application.yml
```
The above files are `.gitignore`d to avoid checking in secret credentials.

To view the list of available options for the config generator run the following command:
`rails g config --help`

## 1b. (Optional) Edit the config cache and re-run config generator
You can now edit the `.esaas-engagements-config.json` with custom values eg. setup a SendGrid API key after setting one up from their website.
After customizing the `.esaas-engagements-config.json` you can re-run `rails g config` to regenerate the config files with these new values.
`.esaas-engagements-config.json` files stores your config values and uses them to regenerate `config/application.yml` and your docker files.

## 2. Start application
You can now start the application locally either on "bare-metal" or inside `docker`.

###  2a. "Bare metal" Approach
For this approach your laptop need to have dependencies such as `nodejs` and `phantomjs` (for testing) installed either using Homebrew(MacOS), Chocoletey(PC) or your Linux package manager.

`rails s`

### 2b. Docker Approach
For this approach you do not need to have dependencies on your host machine installed manually.

Build the docker image:

`docker-compose build`

Run migrations:

`docker-compose run rails-server rake db:migrate`

Seed the database:

`docker-compose run rails-server rake db:seed`

Since there is volume mapping, you only need to run migrations and the seed once, not unless there is a new migration or changes to `seed.rb`.

Spawn the docker network:

`docker-compose up -d`

The `docker` machine that is spawned has volume mapping so changes in code should be reflect immediately.
However, changes to the `Gemfile*` files will require re-building the docker image with `docker-compose build`.

Stop the docker network:

`docker-compose down`

To run tests in your docker machine:

`docker-compose run -e "RAILS_ENV=test" rails-server rake test`


## Deploying to heroku. 
Read the documentation for [working with Rails 4 on Heroku](https://devcenter.heroku.com/articles/getting-started-with-rails4).

If you want to deploy to heroku you should ideally re-clone the repository in a new folder different from your local development folder.
Re-run `rails g config --no-docker` in the new clone.
Edit the `.esaas-engagements.json` with values you want to use in production 
eg. if you have a `SENDGRID` key you want to use for production, overwrite the json key for the key with appropriate values.

Now run `figaro heroku:set -e production -a YOUR+HEROKU+APP+NAME+HERE`.

Replace `YOUR+HEROKU+APP+NAME+HERE` with `example-app` if your heroku app is at `example-app.herokuapp.com`.
