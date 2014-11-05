#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# Kill the whole script on error
set -e -x

echo "-------- Running Typhoeus 0.4 Specs ---------"
bundle install --gemfile=gemfiles/typhoeus_old.gemfile --without extras
BUNDLE_GEMFILE=gemfiles/typhoeus_old.gemfile bundle exec rspec spec/vcr/library_hooks/typhoeus_0.4_spec.rb --format progress --backtrace

# Setup vendored rspec-1
git submodule init
git submodule update

echo "-------- Running Specs ---------"
bundle exec ruby -w -I./spec -r./spec/capture_warnings -rspec_helper -S rspec spec --format progress --backtrace

echo "-------- Running Cukes ---------"
bundle exec cucumber

echo "-------- Checking Coverage ---------"
bundle exec rake yard_coverage

bundle exec rake check_code_coverage
