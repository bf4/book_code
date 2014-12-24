#---
# Excerpted from "Arduino: A Quick-Start Guide, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msard2 for more book information.
#---
require 'rubygems'
require 'serialport'

if ARGV.size != 1
  puts "You have to pass the name of a serial port."
  exit 1
end

port_name = ARGV[0]
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity    = SerialPort::NONE

arduino = SerialPort.new( 
  port_name,
  baud_rate,
  data_bits,
  stop_bits,
  parity
)

sleep 2
while true
  arduino.write "a0\n"
  sleep 0.01
  line = arduino.gets.chomp
  puts line
end

