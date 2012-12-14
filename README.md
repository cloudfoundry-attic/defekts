defects
=======

software defect data warehouse, extracts defects from multiple sources,
normalizes defect information, and provides restful api to access the
warehouse.

dependencies
------------

* ruby 1.9.2-p290 or greater (not tested with 1.9.3)
* sinatra
* thin
* postgresql
* sqlite3 (for development)
* activerecord

install
-------

- clone the source from gerrit
    gerrit clone ssh://reviews.cloudfoundry.org/defects
- modify the conf/database.yml file with your postgresql credentials
- create the database
    rake db:migrate
- start up the web server
    thin start -d -p <port>   # e.g. thin start -d -p 8000
- stop the web server
    thin stop

troubleshooting
---------------

* on occassion, the thin stop command fails to shutdown the server in which
case you'll need to kill the process manually via kill -9 PID


