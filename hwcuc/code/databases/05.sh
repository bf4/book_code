#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
set -e
./04.sh
rm -Rf 05
cp -R 04 05
cd 05
patch --no-backup-if-mismatch -p3 < ../05.diff
../../../script/build-cukes
cat features/cash_withdrawal.pmlcolor
