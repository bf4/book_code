/***
 * Excerpted from "HTML5 and CSS3 Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
***/
(function() {
  var fs, handleEventSourceRequest, http, mime, path, simpleWebServer, url;
  path = require("path");
  http = require("http");
  fs = require("fs");
  url = require("url");
  mime = require("mime");
  handleEventSourceRequest = require("./sse");
  simpleWebServer = function(directory, staticPort, default_page) {
    var handleStaticServerRequest, send404, send500, sendFile, showDirectoryListing, staticServer;
    if (default_page == null) {
      default_page = true;
    }
    staticServer = http.createServer(function(request, response) {
      console.log("Received request for " + request.url);
      if (request.url === "/stream") {
        return handleEventSourceRequest(request, response);
      } else {
        return handleStaticServerRequest(request, response);
      }
    });
    staticServer.listen(staticPort);
    console.log("Serving  " + directory + " listening on port " + staticPort);
    staticServer.on("error", function(error) {
      return console.log("Error: " + error);
    });
    send404 = function(response) {
      response.writeHead(404, {
        "Content-Type": "text/plain"
      });
      response.write("404 Not Found\n");
      return response.end();
    };
    send500 = function(error, response) {
      response.writeHead(500, {
        "Content-Type": "text/html"
      });
      response.write("<h1>Oh Noes!</h1>");
      response.write("<h2>500</h2>");
      response.write("<p>" + error + "</p>");
      return response.end();
    };
    sendFile = function(filename, response) {
      return fs.readFile(filename, "binary", function(err, file) {
        var type;
        if (err) {
          return send500(error, response);
        } else {
          type = mime.lookup(filename);
          response.writeHead(200, {
            "Content-Type": type
          });
          console.log("Serving " + filename);
          response.write(file, "binary");
          return response.end();
        }
      });
    };
    showDirectoryListing = function(filename, uri, response) {
      response.writeHead(200, {
        "Content-Type": "text/html"
      });
      response.write("<html><head><title>Listing " + filename + "</title></head>");
      response.write("<h1>HTML5 and CSS3 Second Edition</h1><hr>");
      response.write("<body><h2>Index of " + filename + "</h2><ul>");
      response.write("<li><a href=\"" + (path.join(uri, "../")) + "\">..</a></li>");
      return fs.readdir(filename, function(err, files) {
        var file, index, output, slash;
        if (err) {
          console.log("Error reading directory:", err);
        } else {
          for (index in files) {
            file = files[index];
            slash = (fs.statSync(path.join(filename, file)).isDirectory() ? "/" : "");
            output = "<li><a href=\"" + (path.join(uri, file) + slash) + "\">" + (file + slash) + "</a></li>";
            response.write(output);
          }
        }
        response.write("</ul>");
        response.write("<hr><h6><a href='http://pragprog.com/titles/bhh52e/'>HTML5 and CSS3 Second Edition</a></h6>");
        response.end("</body></html>");
        return console.log("Serving directory listing for " + filename);
      });
    };
    return handleStaticServerRequest = function(request, response) {
      var filename, uri;
      uri = url.parse(request.url).pathname;
      filename = path.join(directory, uri);
      return fs.exists(filename, function(exists) {
        if (!exists) {
          send404(response);
          return;
        }
        if (fs.statSync(filename).isDirectory()) {
          if (default_page) {
            if (fs.existsSync(filename + "index.html")) {
              filename += "index.html";
            }
          } else {
            showDirectoryListing(filename, uri, response);
            return;
          }
        }
        return sendFile(filename, response);
      });
    };
  };
  simpleWebServer(".", 8000, false);
  simpleWebServer("./html5_cross_document/contactlist", 4000);
  simpleWebServer("./html5_cross_document/supportpage", 3000);
}).call(this);
