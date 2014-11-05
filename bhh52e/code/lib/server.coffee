# Simple static server with MIME based on https://gist.github.com/906395
# Definitely not for production use. 
path = require("path")
http = require("http")
fs = require("fs")
url = require("url")
mime = require("mime")

handleEventSourceRequest = require "./sse"

# Create the simple web server. Pass in the directory, port, and whether
# or not it should show directoy listings. Default behavior
# is that default page is on, meaning that index.html files will 
# be served whenever they are present and the url is a request
# for a directory
simpleWebServer = (directory, staticPort, default_page = true) ->
  staticServer = http.createServer((request, response) ->
    console.log "Received request for #{request.url}"

    if request.url == "/stream"
      handleEventSourceRequest(request,response)
    else
      handleStaticServerRequest(request,response)
  )

  staticServer.listen staticPort

  console.log "Serving  #{directory} listening on port #{staticPort}"

  staticServer.on "error", (error) ->
    console.log("Error: " + error)

  # Serve the 404 response for pages that aren't found
  send404 = (response) ->
    response.writeHead 404,
      "Content-Type": "text/plain"

    response.write "404 Not Found\n"
    response.end()

  # Serve the 500 error
  send500 = (error, response) ->
    response.writeHead 500, "Content-Type": "text/html"
    response.write "<h1>Oh Noes!</h1>"
    response.write "<h2>500</h2>"
    response.write "<p>#{error}</p>"
    response.end()

  # Send the file by reading it from disk, determining the mime type
  # and creating the response.
  sendFile = (filename, response) ->
    fs.readFile filename, "binary", (err, file) ->
      if err
        send500(error, response)
      else 
        type = mime.lookup(filename)
        response.writeHead 200, "Content-Type": type

        console.log "Serving " + filename
        response.write file, "binary"
        response.end()

  # Show the directory listing for the folder
  # by rendering the listing as HTML
  showDirectoryListing = (filename, uri, response) ->
    response.writeHead 200,
      "Content-Type": "text/html"
    response.write "<html><head><title>Listing #{filename}</title></head>"
    response.write "<h1>HTML5 and CSS3 Second Edition</h1><hr>"
    response.write "<body><h2>Index of #{filename}</h2><ul>"
    response.write "<li><a href=\"#{path.join(uri, "../")}\">..</a></li>"

    fs.readdir filename, (err, files) ->
      if err
        console.log "Error reading directory:", err
      else
        for index of files
          file = files[index]
          slash = (if fs.statSync(path.join(filename, file)).isDirectory() then "/" else "")
          output = "<li><a href=\"#{path.join(uri, file) + slash}\">#{file + slash}</a></li>"
          response.write output
      response.write "</ul>"
      response.write "<hr><h6><a href='http://pragprog.com/titles/bhh52e/'>HTML5 and CSS3 Second Edition</a></h6>"      
      response.end "</body></html>"
      console.log "Serving directory listing for #{filename}"

  # Handles the request for static pages.
  handleStaticServerRequest = (request, response) ->
    uri = url.parse(request.url).pathname
    filename = path.join(directory, uri)
    fs.exists filename, (exists) ->
      if !exists
        send404(response)
        return

      if fs.statSync(filename).isDirectory()
        if default_page
          if fs.existsSync(filename + "index.html")
            filename += "index.html"
        else
          showDirectoryListing(filename, uri, response)
          return

      sendFile(filename, response)


simpleWebServer(".", 8000, false)
simpleWebServer("./html5_cross_document/contactlist", 4000)
simpleWebServer("./html5_cross_document/supportpage", 3000)



