books = {
  'dswdcloj' => {
    name: "Web Development with Clojure: Build Bulletproof Web Apps with Less Code",
    author: "Dmitri Sotnikov",
    printing: "P2.0",
    published: "2014-01-15",
    printed: "2014-07-30",
    releases: "https://pragprog.com/titles/dswdcloj/release_info",
    source_code: "http://media.pragprog.com/titles/dswdcloj/code/dswdcloj-code.tgz",
    artifacts: [
      { name: "Clojure Distilled", link: "http://media.pragprog.com/titles/dswdcloj/ClojureDistilled.pdf"},
    ],
  },
  '7lang' => { name: "Seven More Languages in Seven Weeks: Languages That Are Shaping the Future" },
  '7web' => { name: "Seven Web Frameworks in Seven Weeks: Adventures in Better Web Apps" },
  'ahmine2' => { name: "Learn to Program with Minecraft Plugins (2nd edition): Create Flaming Cows in Java Using CanaryMod" },
  'achbd' => { name: "The RSpec Book: Behaviour-Driven Development with RSpec, Cucumber, and Friends" },
  'bhgwad' => { name: "Web Design for Developers: A Programmer's Guide to Design Tools and Techniques" },
  # 'bhh5' => {},
  'bhh52e' => { name: "HTML5 and CSS3 (2nd edition): Level Up with Today's Web Technologies" },
  'bhgrunt' => { name: "Automate with Grunt: The Build Tool for JavaScript" },
  'bhtmux' => { name: "tmux: Productive Mouse-Free Development" },
  'bkviml' => { name: "The VimL Primer: Edit Like a Pro with Vim Plugins and Scripts" },
  'bksqla' => { name: "SQL Antipatterns: Avoiding the Pitfalls of Database Programming" },
  'bmsft' => { name: "Everyday Scripting with Ruby: for Teams, Testers, and You" },
  'btlang' => { name: "Seven Languages in Seven Weeks: A Pragmatic Guide to Learning Programming Languages" },
  'cbdepra' => { name: "Deploying Rails: Automate, Deploy, Scale, Maintain, and Sleep at Night" },
  'cjclojure' => { name: "Mastering Clojure Macros: Write Cleaner, Faster, Smarter Code" },
  'cmelixir' => { name: "Metaprogramming Elixir" },
  # 'dccar' => {},
  'dccar2' => { name: "Build Awesome Command-Line Applications in Ruby 2: Control Your Computer, Simplify Your Life" },
  'dnvim' => { name: "Practical Vim: Edit Text at the Speed of Thought" },
  'd-dsbackm' => { name: "Backbone Marionette" },
  'dhwcr' => { name: "Cucumber Recipes: Automate Anything with BDD Tools and Techniques" },
  'dsproc' => { name: "Rapid Android Development: Build Rich, Sensor-Based Applications with Processing" },
  'elixir' => { name: "Programming Elixir: Functional |> Concurrent |> Pragmatic |> Fun" },
  'gwpy2' => { name: "Practical Programming (2nd edition): An Introduction to Computer Science Using Python 3" },
  'hwcuc' => { name: "The Cucumber Book: Behaviour-Driven Development for Testers and Developers" },
  'fr_quiz' => { name: "Best of Ruby Quiz" },
  'fr_secure' => { name: "Security on Rails" },
  'idgtr' => { name: "Scripted GUI Testing with Ruby" },
  'jaerlang2' => { name: "Programming Erlang (2nd edition)" },
  'jkdepj' => { name: "Deploying with JRuby: Deliver Scalable Web Apps using the JVM" },
  'jkrp' => { name: "Remote Pairing: Collaborative Tools for Distributed Development" },
  'jruby' => { name: "Using JRuby: Bringing Ruby to Java" },
  'jsaccess' => { name: "Design Accessible Web Sites: 36 Keys to Creating Content for All Audiences and Platforms" },
  'jsthreads' => { name: "Working with Ruby Threads" },
  'jsunix' => { name: "Working with Unix Processes" },
  'jstcp' => { name: "Working with TCP Sockets" },
  'jvrails2' => { name: "Crafting Rails 4 Applications: Expert Practices for Everyday Rails Development" },
  'jwnode' => { name: "Node.js the Right Way: Practical, Server-Side JavaScript That Scales" },
  'kcdc' => { name: "The Developer's Code: What Real Programmers Do" },
  'mbfpp' => { name: "Functional Programming Patterns in Scala and Clojure: Write Lean Programs for the JVM" },
  # 'nrtest' => {},
  'nrtest2' => { name: "Rails 4 Test Prescriptions: Build a Healthy Codebase" },
  'pb7con' => { name: "Seven Concurrency Models in Seven Weeks: When Threads Unravel" },
  'pg_git' => { name: "Pragmatic Guide to Git" },
  'pg_sass' => { name: "Pragmatic Guide to Sass" },
  # 'ppmetr' => {},
  'ppmetr2' => { name: "Metaprogramming Ruby 2: Program Like the Ruby Pros" },
  'rails4' => { name: "Agile Web Development with Rails 4" },
  'rcctr' => { name: "Continuous Testing: with Ruby, Rails, and JavaScript" },
  'ruby4' => { name: "Programming Ruby 1.9 & 2.0 (4th edition): The Pragmatic Programmers' Guide" },
  'rr2' => { name: "Rails Recipes: Rails 3 Edition" },
  'rwdata' => { name: "Seven Databases in Seven Weeks: A Guide to Modern Databases and the NoSQL Movement" },
  'shcloj2' => { name: "Programming Clojure (2nd edition)" },
  'sidruby' => { name: "The dRuby Book: Distributed and Parallel Computing with Ruby" },
  'tbajs' => { name: "Async JavaScript: Build More Responsive Apps with Less Code" },
  # 'tbcoffee' => {},
  'tbcoffee2' => { name: "CoffeeScript: Accelerated JavaScript Development, Second Edition" },
  'warv' => { name: "The Rails View: Create a Beautiful and Maintainable User Experience" },
  'wbdev' => { name: "Web Development Recipes" },
}
require 'fileutils'
def in_dir(dirname, &block)
  FileUtils.mkdir_p(dirname)
  Dir.chdir(dirname,&block)
end
def extract_code?
  not File.directory?("code")
end
def tar_file(prag_ref)
  @tar_file ||= {}
  @tar_file.fetch(prag_ref) do
    @tar_file[prag_ref] = "#{prag_ref}-code.tgz"
  end
end
def download_code?(prag_ref)
  not File.file?(tar_file(prag_ref))
end
def download_code(prag_ref)
  source_code = "http://media.pragprog.com/titles/#{prag_ref}/code/#{tar_file(prag_ref)}"
  puts `curl -q -O #{source_code}`
  # need error handling and messaging
  if $?.success?
    true
  else
    STDERR.puts "Failed downloading #{prag_ref} code #{$?.class} #{$?.inspect}"
    false
  end
end
def extract_code(prag_ref)
  puts `tar xzf #{tar_file(prag_ref)}`
  # need error handling and messaging
  if $?.success?
    true
  else
    STDERR.puts "Failed extracting #{prag_ref} code #{$?.class} #{$?.inspect}"
    false
  end
end
# def tar_exists?
# check for already downloaded books
puts
books.each do |prag_ref, details|
  in_dir(prag_ref) do
    print '.'
    if extract_code?
      if download_code?(prag_ref)
        next unless download_code(prag_ref)
      end
      next unless extract_code(prag_ref)
      # handle artifacts
      # handle different releases
    end
    `git add code && git commit -m "Adding code #{prag_ref}: #{details[:name]}"`.strip
  end
end
