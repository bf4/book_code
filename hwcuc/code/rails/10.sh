#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
set -e
cp -R 09 10
cd 10
patch --no-backup-if-mismatch -p3 < ../10.diff

cat << 'EOF' > config/routes.rb
Squeaker::Application.routes.draw do
  resources :users
end
EOF

../../../script/build-cukes
