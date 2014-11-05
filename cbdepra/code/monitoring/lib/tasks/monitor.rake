namespace :nagios do
  desc "Nagios monitor for recent accounts"
  task :accounts => :environment do
    recent = Account.where("created_at > ?", 1.day.ago).count
    msg, exit_code = if recent > 90
      ["CRITICAL", 2]
    elsif recent > 50
      ["WARNING", 1]
    else
      ["OK", 0]
    end
    puts "ACCOUNTS #{msg} - #{recent} accounts created in the past day"
    exit exit_code
  end
end
