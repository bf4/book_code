namespace :log do
  task :debug do
    JMX::MBean.establish_connection :command => "org/jruby/Main -S trinidad"
    logging = JMX::MBean.find_by_name "twitalytics:name=LoggingBean"
    puts logging.set_log_level(0)
  end
end