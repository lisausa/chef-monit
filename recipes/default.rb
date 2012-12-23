package "monit" do
  action :install
end

execute 'disable init.d/monit in favor of Upstart' do
  command 'update-rc.d -f monit remove'
end

cookbook_file '/etc/init/monit.conf' do
  source 'init.monit.conf'
  owner "root"
  group "root"
  mode 0644
end

service "monit" do
  action :start
  enabled true
  supports [:start, :restart, :stop]
  provider Chef::Provider::Service::Upstart
end

template "/etc/monit/monitrc" do
  owner "root"
  group "root"
  mode 0700
  source 'monitrc.erb'
  notifies :restart, resources(:service => "monit"), :immediate
end


