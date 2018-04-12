# START:from
FROM ruby:2.4                                           #<label id="code.dockerfile2.FROM"/>
# END:from

# START:run-instructions
RUN apt-get update -yqq                                 #<label id="code.dockerfile2.RUN-apt-get-update"/>
RUN apt-get install -yqq --no-install-recommends nodejs #<label id="code.dockerfile2.RUN-apt-get-install-node"/>
# END:run-instructions

# START:copy
COPY . /usr/src/app/                                    #<label id="code.dockerfile2.COPY"/>
# END:copy

# START:workdir
WORKDIR /usr/src/app                                    #<label id="code.dockerfile2.WORKDIR"/>
# END:workdir
# START:bundle-install
RUN bundle install                                      #<label id="code.dockerfile2.RUN-bundle-install"/>
# END:bundle-install

