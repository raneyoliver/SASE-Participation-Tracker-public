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
2. Run `cd frontend/src`, then `npm i` to install packages

## Database setup
1. Install postgreSQL, make sure you remember your username and password
2. Create a new file called `.env` in the root directory with the following content:
```
POSTGRES_USERNAME=<your username here>
POSTGRES_PASSWORD=<your password here>
```
This will set environment variables with the `dotenv` gem, which will be loaded in `config/database.yml`.

## Compiling frontend files
If you have VS Code, create a `.vscode` folder (if not already present) in the root folder and put the following to set up linting/automatic compilation:
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
        "./frontend/src"
    ],
}
```
Then, open the command palette and select "Tasks: Run Task" > "npm" > "npm: dev". This will watch the frontend files and automatically recompile them when changes are made.

If you don't have VS code, you can cd to `frontend/src` and run `npm run dev` (to compile js files), or `npm run dev` (to run linting).

# Running the server
Run `rails server` and navigate to `localhost:3000` in your browser.


# Tool Set Up
Run `install bundler` to install new changes made in Gemfile.

## RuboCop
RuboCop is a static code analyser and code formatter. It will auto-crrect many of the code offenses it detects.
The gemfile has already been changed to include  `gem 'rubocop', '~> 0.90.0', require: false`
Run `rubocop` in the root folder

## SimpleCov
SimpleCov is a code coverage anaylis took for Ruby.
The gemfile has already been changed to include `gem 'simplecov', require: false, group: :test`
To add a file for code coverage do the following:
Add `require "simplecov"` at the top of the ruby file.
Add `SimpleCov.start` underneath the require.
Run `rake test` to generate the html file that has the coverage report.

## Cucumber
Cucumber is a tool for running automated tests.
The gemfile has already been changed to include `gem 'cucumber'`
A features folder has been added to the root directory to include a sample testing for Cucumber.
Run `cucumber features/demo.feature` in the root folder to see cucumber in action.

## RSpec
RSpec is a computer domain-specific language testing tool written in Ruby to test Ruby code.
The gemfile has already been changed to include `gem "rspec"`
Run `rspec --init`



