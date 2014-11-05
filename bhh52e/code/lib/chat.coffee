chatPort = 9394
webSocketServer = require("websocket").server
http = require('http')

clients = []

# basic server for the flashpolicyserver and chatserver.
server = http.createServer (request, response) ->
  console.log("creating server")

server.listen chatPort, ->
  console.log "Websocket Chat Server listening on port #{chatPort}"

  
wsServer = new webSocketServer httpServer: server

wsServer.on 'request', (request) ->
  conn = request.accept null, request.origin
  
  currentClientIndex = (clients.push(conn)) - 1
  user = 
    userName: "ChatUser#{currentClientIndex}"

  console.log("Connection accepted")

  sendToEveryoneElse "* #{user.userName} has joined!", conn 
  
  conn.on "message", (message) ->
    if message.type == 'utf8'
      if message.utf8Data.charAt(0) == "/"
        parseCommand(message, user)
      else
        sendToEveryone "#{user.userName} : #{message.utf8Data}"

  conn.on "close", (message) ->
    clients.splice(currentClientIndex, 1)
    console.log "*** #{user.userName} disconnected - peer closed."

parseCommand = (message, user) ->
  nickRegex = (/^\/nick (.*)/)
  nickname = message.utf8Data.match(nickRegex)
  if nickname
    oldName = user.userName
    user.userName = nickname[1]
    sendToEveryone "*** #{oldName} is now known as #{user.userName}"

sendToEveryone = (message) ->
  client.sendUTF message for client in clients

sendToEveryoneElse = (message, currentClient) ->
  for client in clients
    unless client == currentClient
      client.sendUTF message

