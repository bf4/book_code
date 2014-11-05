namespace :archive do
  task :dump_old_records_to_sql => :environment do
    threshold = 6.months.ago.beginning_of_day
    next if Version.exists("item_type = ? and created_at < ?", "Account", threshold)
    outdir = ENV['OUTDIR'] || Rails.root
    outfile = File.join(outdir, "#{threshold.strftime('%Y%m%d')}.sql")
    where = "created_at < '#{threshold.strftime("%Y-%m-%d")}'"
    config = ActiveRecord::Base.configurations[RAILS_ENV]
    command = "mysqldump "
    command << " -u#{config['username']} "
    command << " -p#{config['password']} " if config['password'].present?
    command << " --single-transaction "
    command << " --quick "
    command << " --tables "
    command << " --where \"#{where}\" "
    command << " #{config['database']} "
    command << " versions "
    command << " > #{outfile} "
    # Dump the records
    `#{command}`
    # Delete the records
    Version.delete_all(["created_at < ?", threshold])
  end
end
