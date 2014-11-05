/***
 * Excerpted from "Async JavaScript",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/tbajs for more book information.
***/
var cluster = require('cluster');
if (cluster.isMaster) {
  // spin up workers
  var coreCount = require('os').cpus().length;
  for (var i = 0; i < coreCount; i++) {
    cluster.fork();
  }
  // bind death event
  cluster.on('death', function(worker) {
    console.log('Worker ' + worker.pid + ' has died');
  });
} else {
  // die immediately
  process.exit();
}