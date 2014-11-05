#---
# Excerpted from "Deploying Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cbdepra for more book information.
#---
set :cleanup_targets, %w(log public/system tmp)
set :release_directories, %w(log tmp)
set :release_symlinks do
  {
    "config/settings/#{stage}.yml" => 'config/settings.yml',
    "config/database/#{stage}.yml" => 'config/memcached.yml',
  }
end
set :shared_symlinks, {
  'log'     => 'log',
  'pids'    => 'tmp/pids',
  'sockets' => 'tmp/sockets',
  'system'  => 'public/system'
}

