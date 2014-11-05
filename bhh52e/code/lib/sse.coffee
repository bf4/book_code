handleEventSourceRequest = (request, response) ->
  console.log("A request has been made to get the stream.")
  response.writeHead(200, {
    "Content-Type":"text/event-stream;charset=UTF-8", 
    "Cache-Control":"no-cache", 
    "Connection":"keep-alive"
  }
  )
  response.write("retry: 10000\n")
  response.write("event: connected\n")
  response.write("data: Connection established\n\n")

  messages = [
      "We are bringing even more awesomeness to you!",
      "Check out AwesomeComf on Twitter",
      "Are you ready to be even more awesome?",
      "Don't be awesful. Be awesome instead!"
  ]

  interval = setInterval -> 
    message = ("data: " + messages[Math.floor(Math.random() * messages.length)] + "\n\n")
    console.log message
    response.write message
  , 5000

module.exports = handleEventSourceRequest
