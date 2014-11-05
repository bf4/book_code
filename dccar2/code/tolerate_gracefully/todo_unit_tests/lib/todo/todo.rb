#---
# Excerpted from "Build Awesome Command-Line Applications in Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dccar2 for more book information.
#---
module Todo
  def new_task(filename,task_names)
    File.open(filename,'a+') do |todo_file|
      tasks = 0
      task_names.each do |task| 
        todo_file.puts [task,Time.now].join(',')
        tasks += 1
      end
      if tasks == 0
        raise "You must provide tasks on the command-line or standard input" 
      end
    end
  end
end

module Todo
  def new_task(filename,task_names)
    File.open(filename,'a+') do |todo_file|
      tasks = 0
      task_names.each do |task| 
        todo_file.puts [task,Time.now].join(',')
        tasks += 1
      end
      if tasks == 0
        raise "You must provide tasks on the command-line or standard input" 
      end
    end
  rescue SystemCallError => ex
    raise RuntimeError,"Couldn't open #{filename} for appending: #{ex.message}"
  end
end
