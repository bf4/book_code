#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class TodoApi

  def initialize(listener_lambda)
    @listener_lambda = listener_lambda
    config = NSURLSessionConfiguration.defaultSessionConfiguration
    config.HTTPAdditionalHeaders = {"Accept" => "application/json",
                                    "Content-Type" => "application/json"}
    @session = NSURLSession.sessionWithConfiguration(config)
  end

  def get_all_todos
    url = NSURL.URLWithString(base_url)
    request = NSURLRequest.requestWithURL(url)
    task = @session.dataTaskWithRequest(request,
                      completionHandler:lambda { |data, response, error|
      if error.nil?
        jsonError = Pointer.new(:object)
        responseDict = NSJSONSerialization.JSONObjectWithData(data,
                                                      options:0,
                                                        error:jsonError)
        if jsonError[0].nil?
          Dispatch::Queue.main.async do
            @listener_lambda.call responseDict
          end
        else
          Dispatch::Queue.main.async do
            @listener_lambda.call nil, jsonError[0]
          end
        end
      else
        Dispatch::Queue.main.async do
            @listener_lambda.call nil, error
        end
      end
    })
    task.resume
  end

  def base_url
    "http://localhost:3000/todos"
  end

end
