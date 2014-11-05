MYSQL=/opt/local/bin/mysql5
USER=
PASS=
DB=test
MYSQLCMD=$(MYSQL) -u$(USER) -p$(PASS) $(DB) --verbose

all: setup

setup:
	$(MYSQLCMD) -e "source setup.sql"
