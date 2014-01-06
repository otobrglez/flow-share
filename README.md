# flow-share

Project by [Oto Brglez](https://github.com/otobrglez) for [Fika, Inc.](http://wefika.com) &copy; 2014

## Developement setup

### OS X Shared memory settings
You might need to add the following to your /etc/sysctl.conf file (if it doesn't exist, create it):

    kern.sysv.shmall=65536
    kern.sysv.shmmax=16777216

### Create new PG database structure
    initdb db/pg-data -E utf8

### Create databases and migrate
    rake db:create db:migrate db:test:prepare

### For parallel tests please prepare database
    rake parallel:create parallel:prepare

### Troubles
  - [PostgreSQL basics by example](http://darthdeus.github.io/blog/2013/08/19/postgresql-basics-by-example/)
  - [RailsCasts: #342 Migrating to PostgreSQL](http://railscasts.com/episodes/342-migrating-to-postgresql)

### Run Foreman to run PG
    foreman start -f Procfile.development

## TDD with Guard
    guard
