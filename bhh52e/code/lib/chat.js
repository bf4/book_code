/***
 * Excerpted from "HTML5 and CSS3 Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
***/
(function() {
  var chatPort, clients, http, parseCommand, sendToEveryone, sendToEveryoneElse, server, webSocketServer, wsServer;
  chatPort = 9394;
  webSocketServer = require("websocket").server;
  http = require('http');
  clients = [];
  server = http.createServer(function(request, response) {
    return console.log("creating server");
  });
  server.listen(chatPort, function() {
    return console.log("Websocket Chat Server listening on port " + chatPort);
  });
  wsServer = new webSocketServer({
    httpServer: server
  });
  wsServer.on('request', function(request) {
    var conn, currentClientIndex, user;
    conn = request.accept(null, request.origin);
    currentClientIndex = (clients.push(conn)) - 1;
    user = {
      userName: "ChatUser" + currentClientIndex
    };
    console.log("Connection accepted");
    sendToEveryoneElse("* " + user.userName + " has joined!", conn);
    conn.on("message", function(message) {
      if (message.type === 'utf8') {
        if (message.utf8Data.charAt(0) === "/") {
          return parseCommand(message, user);
        } else {
          return sendToEveryone("" + user.userName + " : " + message.utf8Data);
        }
      }
    });
    return conn.on("close", function(message) {
      clients.splice(currentClientIndex, 1);
      return console.log("*** " + user.userName + " disconnected - peer closed.");
    });
  });
  parseCommand = function(message, user) {
    var nickRegex, nickname, oldName;
    nickRegex = /^\/nick (.*)/;
    nickname = message.utf8Data.match(nickRegex);
    if (nickname) {
      oldName = user.userName;
      user.userName = nickname[1];
      return sendToEveryone("*** " + oldName + " is now known as " + user.userName);
    }
  };
  sendToEveryone = function(message) {
    var client, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = clients.length; _i < _len; _i++) {
      client = clients[_i];
      _results.push(client.sendUTF(message));
    }
    return _results;
  };
  sendToEveryoneElse = function(message, currentClient) {
    var client, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = clients.length; _i < _len; _i++) {
      client = clients[_i];
      _results.push(client !== currentClient ? client.sendUTF(message) : void 0);
    }
    return _results;
  };
}).call(this);
