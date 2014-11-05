#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
set -e
./03.sh
rm -Rf 04
cp -R 03 04
cd 04
patch --no-backup-if-mismatch -p3 < ../04.diff
sqlite3 db/bank.db "delete from accounts;"
../../../script/build-cukes
# Break line in output
sed -i '' -e 's/lib\/active_record.*$/\
&/' features/cash_withdrawal.pmlcolor

sed -i '' -e 's/Couldn.*$/\
&/' features/cash_withdrawal.pmlcolor

cat features/cash_withdrawal.pmlcolor
