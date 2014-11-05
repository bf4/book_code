/***
 * Excerpted from "HTML5 and CSS3 Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
***/
(function() {
  var pf;
  pf = require('policyfile').createServer();
  pf.listen(843, function() {
    return console.log("Flash Policy server listening on port 843");
  });
  pf.on("error", function(message) {
    return console.log("*******************************************************************\n* CAN'T START POLICY SERVER. Port 843 requires you to run as root *\n* Try running this with sudo node server instead.                 *\n*******************************************************************");
  });
}).call(this);
