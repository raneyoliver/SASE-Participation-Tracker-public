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
