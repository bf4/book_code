#---
# Excerpted from "Build Awesome Command-Line Applications in Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dccar2 for more book information.
#---
module Todo
  class Task
    def self.new_task(filename,task_names)
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
end

module Todo
  class Task
    def self.new_task(filename,task_names)
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
end

module Todo
  class Task
    def self.from_file(file)
      tasks = []
      file.readlines.each do |line|
        name,created,completed = line.chomp.split(/,/)
        tasks << Task.new(name,created,completed)
      end
      tasks
    end
  end
  class Task
    attr_reader :name,
                :created_date,
                :completed_date

    def initialize(name,created_date,completed_date)
      @name = name
      @created_date = created_date
      @completed_date = completed_date
    end

    def completed?
      !completed_date.nil?
    end

    def self.to_file(task,file)
      file.puts [task.name,task.created_date,task.completed_date].join(',')
    end

    
    def self.new_task(filename,task_names)
      File.open(filename,'a+') do |todo_file|
        tasks = 0
        Array(task_names).map { |name|
          Task.new(name,Time.now,nil)
        }.each do |task|
          to_file(task,todo_file)
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
end

module Todo
  class Task
    def complete
      @completed_date = Time.now
    end

    def self.write(filename,tasks)
      File.open(filename,'w') do |todo_file|
        tasks.each do |task|
          to_file(task,todo_file)
        end
      end
    end
  end
end


