#!/bin/bash
#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
TEST_SERVER_PORT=34777 
MOBILE_APP_PACKAGE=$1
if [ -z "$MOBILE_APP_PACKAGE" ]; then
   echo 'The parameter about your mobile app package is missing: e.g. com.springsource.greenhouse.test'
   exit 1
else
   # use this line for calabash version 0.1
   # adb shell am instrument -e class sh.calaba.instrumentationbackend.InstrumentationBackend -w $MOBILE_APP_PACKAGE/android.test.InstrumentationTestRunner &
  adb shell am instrument -e class sh.calaba.instrumentationbackend.InstrumentationBackend -w $MOBILE_APP_PACKAGE/sh.calaba.instrumentationbackend.CalabashInstrumentationTestRunner &
   sleep 7
   IRBRC=.irbrc TEST_SERVER_PORT=$TEST_SERVER_PORT irb
fi
