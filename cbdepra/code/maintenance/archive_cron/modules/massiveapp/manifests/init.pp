cron {
  "massiveapp_archive":
    command => "RAILS_ENV=production \
      /usr/local/bin/rake archive:dump_old_records_to_sql",
    user    => "vagrant",
    hour    => "0",
    minute  => "10"
}

