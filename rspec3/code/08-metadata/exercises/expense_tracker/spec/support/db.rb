#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
RSpec.configure do |c|
  # ...

  c.before(:suite) do
    Sequel.extension :migration
    Sequel::Migrator.run(DB, 'db/migrations')
    DB[:expenses].truncate

    FileUtils.mkdir_p('log')
    require 'logger'
    DB.loggers << Logger.new('log/sequel.log')
  end

  c.around(:example, :db) do |example|
    DB.log_info "Starting example: #{example.metadata[:description]}"
    DB.transaction(rollback: :always) { example.run }
    DB.log_info "Ending example: #{example.metadata[:description]}"
  end
end
