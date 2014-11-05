#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
require 'thread'
require_relative 'concurrent_each'

class FileUploader
  attr_reader :results

  def initialize(files)
    @files = files
    @results = Queue.new
  end

  def upload
    @files.concurrent_each do |(filename, file_data)|
      status = upload_to_s3(filename, file_data)
      @results << status
    end
  end

  def upload_to_s3(filename, file)
    # omitted
  end
end

uploader = FileUploader.new('boots.png' => '*pretend png data*', 'shirts.png' => '*pretend png data*')
uploader.upload

puts uploader.results.size

