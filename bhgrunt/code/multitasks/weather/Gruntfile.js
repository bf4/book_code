/***
 * Excerpted from "Automate with Grunt",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhgrunt for more book information.
***/
module.exports = function(grunt){
  
  grunt.config.init({
    weather: {
      home: 60623,
      work: 60622
    }
  });

  grunt.registerMultiTask('weather', 'Fetches weather', function() {

    var done, http, location, request, requestOptions,  zipCode;

    location = this.target;
    zipCode = this.data;




    requestOptions = {
      host: 'api.openweathermap.org',
      path: '/data/2.5/weather?units=imperial&q=' + zipCode,
      port: 80,
      method: 'GET'
    }

    http = require('http');

    done = this.async(); 

    request = http.request(requestOptions, function(response) {
      var buffer = [];

      response.on('data', function(data){
        buffer.push(data);
      });

      response.on('end', function(){
        var weather = JSON.parse(buffer.join());
        console.log(location + ' : ' + weather.main.temp + ' degrees');

        done(); 
        
      });
    });

    request.end();
  });
  
}

