#---
# Excerpted from "Arduino: A Quick-Start Guide, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msard2 for more book information.
#---
use strict;
use warnings;
use Device::SerialPort;

my $num_args = $#ARGV + 1;
if ($num_args != 1) {
    die "You have to pass the name of a serial port.";
}

my $serial_port = $ARGV[0];
my $arduino = Device::SerialPort->new($serial_port); 
$arduino->baudrate(9600);
$arduino->databits(8);
$arduino->parity("none");
$arduino->stopbits(1);
$arduino->read_const_time(1); 
$arduino->read_char_time(1);

sleep(2);
while (1) {
  $arduino->write("a0\n");
  my ($count, $line) = $arduino->read(255);
  print $line;
}

