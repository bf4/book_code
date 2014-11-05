/***
 * Excerpted from "Node.js the Right Way",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jwnode for more book information.
***/
"use strict";
const
  cluster = require('cluster'),
  zmq = require('zmq');

if (cluster.isMaster) {
  
  // master process
  // - create PUSH and SUB sockets, bind IPC endpoints
  let
    pusher = zmq.socket('push').bind('ipc://filer-pusher.ipc'),
    puller = zmq.socket('pull').bind('ipc://filer-puller.ipc'),
    
    readyCount = 0,
    
    sendWork = function(){
      // all workers are ready, send out thirty jobs
      for (let i = 0; i < 30; i++) {
        pusher.send(JSON.stringify({index: i}));
      }
    };
  
  // listen for worker messages
  puller.on('message', function(data) {
    
    let message = JSON.parse(data);
    
    if (message.ready) {
      readyCount += 1;
      if (readyCount === 3) {
        sendWork();
      }
    } else if (message.result) {
      console.log('received: ' + data); 
    }
    
  });
  
  // fork three worker processes
  for (let i = 0; i < 3; i++) {
    cluster.fork();
  }
  
  // listen for workers to come online
  cluster.on('online', function(worker) {
    console.log('Worker ' + worker.process.pid + ' is online.');
  });
  
} else {
  
  // worker process
  // - create PULL socket, connect to master's PUSH
  // - create PUB socket, connect to master's SUB
  let
    puller = zmq.socket('pull').connect("ipc://filer-pusher.ipc"),
    pusher = zmq.socket('push').connect("ipc://filer-puller.ipc");
  
  puller.on('message', function(data) {
    
    // parse incoming message
    let job = JSON.parse(data);
    console.log(process.pid + " received job: " + job.index);
    
    // publish response
    pusher.send(JSON.stringify({
      index: job.index,
      pid: process.pid,
      result: 'success'
    }));
    
  });
  
  // signal ready
  pusher.send(JSON.stringify({
    ready: true,
    pid: process.pid
  }));
  
}

