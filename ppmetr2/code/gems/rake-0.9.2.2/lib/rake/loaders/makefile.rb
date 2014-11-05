#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Rake

  # Makefile loader to be used with the import file loader.
  class MakefileLoader
    include Rake::DSL

    SPACE_MARK = "\0"

    # Load the makefile dependencies in +fn+.
    def load(fn)
      lines = File.read fn
      lines.gsub!(/\\ /, SPACE_MARK)
      lines.gsub!(/#[^\n]*\n/m, "")
      lines.gsub!(/\\\n/, ' ')
      lines.each_line do |line|
        process_line(line)
      end
    end

    private

    # Process one logical line of makefile data.
    def process_line(line)
      file_tasks, args = line.split(':', 2)
      return if args.nil?
      dependents = args.split.map { |d| respace(d) }
      file_tasks.scan(/\S+/) do |file_task|
        file_task = respace(file_task)
        file file_task => dependents
      end
    end

    def respace(str)
      str.tr SPACE_MARK, ' '
    end
  end

  # Install the handler
  Rake.application.add_loader('mf', MakefileLoader.new)
end
