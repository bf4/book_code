require 'ant'

namespace :ant do
  task :compile do
    ant.javac :srcdir => "."
  end
end
