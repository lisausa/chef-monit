default[:monit][:enable_email]          = true

default[:monit][:notify_email]          = "notify@example.com"

default[:monit][:poll_period]           = 60
default[:monit][:poll_start_delay]      = 120

default[:monit][:mail_format][:subject] = "$SERVICE $EVENT"
default[:monit][:mail_format][:from]    = "monit@#{node['fqdn']}"
default[:monit][:mail_format][:message]    = <<-EOS
Monit $ACTION $SERVICE at $DATE on $HOST: $DESCRIPTION.

Yours sincerely,
monit
EOS

default[:monit][:mailserver][:hostname] = "localhost"
default[:monit][:mailserver][:port] = nil
default[:monit][:mailserver][:username] = nil
default[:monit][:mailserver][:password] = nil
default[:monit][:mailserver][:password_suffix] = nil
default[:monit][:mailserver][:use_tls] = false

default[:monit][:port] = 3737
default[:monit][:address] = "0.0.0.0"
default[:monit][:ssl] = false
default[:monit][:cert] = "/etc/monit/monit.pem"
default[:monit][:allow] = ['0.0.0.0/0']

default[:monit][:check_system][:alerts] = [
  'loadavg (1min) > 4',
  'loadavg (5min) > 2',
  'memory usage > 95%',
  'cpu usage (user) > 90%',
  'cpu usage (system) > 30%',
  'cpu usage (wait) > 20%'
]