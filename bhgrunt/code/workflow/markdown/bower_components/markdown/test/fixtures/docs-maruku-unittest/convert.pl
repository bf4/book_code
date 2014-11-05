#---
# Excerpted from "Automate with Grunt",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/bhgrunt for more book information.
#---
use strict;
use warnings;
open(LS, "ls -1 *.md|") or die;
my @list = <LS>;
close(LS);

foreach (@list) {
    chomp;
    s/\.md$//;
    my ($markdown, $html) = convert_to_perl_test("$_.md");
    open(MD, ">$_.text") or die;
    print MD $markdown;
    close(MD);
    open(MD, ">$_.html") or die;
    print MD $html;
    close(MD);
}

sub convert_to_perl_test {
    my ($file) = @_;
    my $FH;
    open($FH, '<', $file) or die("Cannot open $file");
    my ($markdown, $html);
    my @lines = <$FH>;
    close($FH);
    my $mode = 0;
    foreach my $l (@lines) {
        if ($l =~ /^\*\*\*/) {
            $mode = 0;
            if ($l =~ /Markdown input/i) {
                $mode = 1;
            }
            if ($l =~ /Output of to_html/) {
                $mode = 2;
            }
        }
        elsif ($mode > 0) {
            if (1 == $mode) {
                $markdown .= $l;
            }
            else {
                $html .= $l;
            }
        }
    }
    return ($markdown, $html);
}
