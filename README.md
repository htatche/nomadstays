# Nomad | Stays

### For Developers

We are still working on the database schema, so to avoid creating a myriad of new migrations we just modify
previous one.

In order to update your local codebase after pulling the code please do so:

    git pull origin master
    rake db:reset

This will re-run all the migrations and leave you with a clean database

Don't forget to run

    bower update

Register a user. You can use [mailcatcher](http://mailcatcher.me/) to catch confirmation email content
or just read the log.

#### Rubocop

Run `rubocop` and fix suggested issues.

#### Rspec

Run `rspec` for testing
