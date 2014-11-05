#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
set -e
./01.sh
rm -Rf 02
cp -R 01 02
cd 02
patch --no-backup-if-mismatch -p3 < ../02.diff
../../../script/build-cukes
# Break line in output
sed -i '' -e 's/lib\/active_record.*$/\
&/' features/cash_withdrawal.pmlcolor

sed -i '' -e 's/Couldn.*$/\
&/' features/cash_withdrawal.pmlcolor

cat features/cash_withdrawal.pmlcolor
