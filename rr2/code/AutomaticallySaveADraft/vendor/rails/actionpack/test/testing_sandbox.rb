#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module TestingSandbox

  # This whole thing *could* be much simpler, but I don't think Tempfile,
  # popen and others exist on all platforms (like Windows).
  def execute_in_sandbox(code)
    test_name = "#{File.dirname(__FILE__)}/test.#{$$}.rb"
    res_name = "#{File.dirname(__FILE__)}/test.#{$$}.out"

    File.open(test_name, "w+") do |file|
      file.write(<<-CODE)
        $:.unshift "../lib"
        block = Proc.new do
          #{code}
        end
        print block.call
      CODE
    end

    system("ruby #{test_name} > #{res_name}") or raise "could not run test in sandbox"
    File.read(res_name)
  ensure
    File.delete(test_name) rescue nil
    File.delete(res_name) rescue nil
  end

end
