# Installation and Setup

## Repo setup
`git clone` this repo, then run the following to prevent changes to certain files from being tracked:
```bash
git update-index --assume-unchanged .vscode
git update-index --assume-unchanged .env
```

## Rails setup
Run `bundle install` to install ruby dependencies

## Frontend setup
1. Install npm
2. Run `npm i` to install packages

## Database setup
1. Install postgreSQL, make sure you remember your username and password
2. Create a new file called `.env` in the root directory with the following content:
```
POSTGRES_USERNAME=<your username here>
POSTGRES_PASSWORD=<your password here>
```
3. If you want to setup email confirmations, put the gmail address and app password (created after 2-step verification is activated) in the .env file:
```
GMAIL_USERNAME=<your gmail address here>
GMAIL_PASSWORD=<your app password here>
```

This will set environment variables with the `dotenv` gem, which will be loaded in `config/database.yml`.

## Compiling frontend files
If you have VS Code, create a `.vscode` folder (if not already present) in the root folder containing a file called `settings.json` with the following content to set up linting/automatic compilation:
```json
{
    "eslint.run": "onSave",
    "eslint.validate": [
        "javascript",
        "javascriptreact",
        {
            "language": "typescript",
            "autoFix": false
        },
        {
            "language": "typescriptreact",
            "autoFix": false
        }
    ],
    "eslint.workingDirectories": [
        "./"
    ],
}
```
Then, open the command palette and select "Tasks: Run Task" > "npm" > "npm: dev". This will watch the frontend files and automatically recompile them when changes are made.

If you don't have VS code, you can run `npm run dev` (to compile js files).

# Running the server
Run `rails server` and navigate to `localhost:3000` in your browser.

# Testing Code
Run `install bundler` to install new changes made in Gemfile.

## RuboCop
RuboCop is a static code analyser and code formatter. It will auto-correct many of the code offenses it detects.
The gemfile has already been changed to include  `gem 'rubocop', '~> 0.90.0', require: false`.
1. Run `rubocop` in the root folder.

## ESLint
ESLint is a static code analysis tool for indentifying problematic patterns found in Javascript.
1. Run `npm run lint` in the root folder.

## SimpleCov
SimpleCov is a code coverage anaylis tool for Ruby.
The gemfile has already been changed to include `gem 'simplecov', require: false, group: :test`.
To add a file for code coverage do the following:
1. Add `require "simplecov"` at the top of the ruby file.
2. Add `SimpleCov.start` underneath the require.
3. Run `rake test` to generate the html file that has the coverage report.

## Cucumber
Cucumber is a tool for running automated tests.
The gemfile has already been changed to include `gem 'cucumber'`.
A features folder has been added to the root directory to include a sample testing for Cucumber.
To run cucumber tests in a headless browser, run `export SELENIUM_CONFIG="HEADLESS"`.
### Test a Single Feature
1. Run `cucumber features/demo.feature` in the root folder to see cucumber in action.
### Test all Features
1. Run `bundler exec cucumber` in the root folder to see cucumber in action.

## RSpec
RSpec is a computer domain-specific language testing tool written in Ruby to test Ruby code.
The gemfile has already been changed to include `gem "rspec"`.
1. Run `bundler exec rspec` in the root folder.

## CI
All tests will run on every push to a given branch.

## Security tests
Security tests are integrated into RSpec and Cucumber tests, they will run along with all other tests. 

### Security Analysis
There are multiple layers of security in the Participation Tracker application. Authentication is checked both on the front end and for sensitive API routes. This provides redundancy in case one layer should fail or be bipassed. Additionally, all user input is validated and properly handled such that injection attacks are mitigated. The only thing that might be considered a security vulnerability is that Heroku does not force HTTPS by default. This means that credentials are available in plaintext in transit, and could potentially be extracted if a malicious actor were listening on the network where a login occured. Even should this happen, however, the most sensitive student information, such as UIN's, is stored as a hash, meaning it would be useless outside the context of the application. Still, to avoid this risk it is best to always access the site using https://, and avoid logging in if you think someone might be listening to your wifi traffic.

# Heroku Deployment

## Setting up Heroku
1. Install Git
2. Install npm
3. Run `npm i -g heroku`
4. Run `heroku login` and enter your credentials.
5. Run `git clone https://github.com/ryan-conn/SASE-Participation-Tracker.git` to get the project locally.
6. Go into the directory that got created after running the previous command.
7. Run `heroku git:remote -a sase-participation-tracker` to link your local installation with heroku.

## Deploying
1. Run `git fetch; git checkout master; git reset --hard origin/master` to preview the changes you want to deploy.
2. Run `git push heroku master` to upload the new project to heroku.
3. If database changes have been made, run `heroku run rails db:migrate`
