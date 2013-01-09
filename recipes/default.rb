package "monit" do
  action :install
end

execute 'disable init.d/monit in favor of Upstart' do
  command '/etc/init.d/monit stop; update-rc.d -f monit remove'
end

cookbook_file '/etc/init/monit.conf' do
  source 'init.monit.conf'
  owner "root"
  group "root"
  mode 0644
end


template "/etc/monit/monitrc" do
  owner "root"
  group "root"
  mode 0700
  source 'monitrc.erb'
  notifies :reload, 'service[monit]'
end

directory '/etc/monit/conf.d' do
  owner "root"
  group "root"
  mode 00755
end

template "/etc/monit/conf.d/system.conf" do
  owner "root"
  group "root"
  mode 00644
  variables(
    hostname: node['fqdn'],
    alerts: node[:monit][:check_system][:alerts]
  )
  notifies :reload, 'service[monit]'
end

service "monit" do
  action :start
  enabled true
  supports [:start, :restart, :stop, :reload]
  provider Chef::Provider::Service::Upstart
end