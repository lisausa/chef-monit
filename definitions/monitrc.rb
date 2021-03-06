# reload: Reload monit so it notices the new service.  :delayed (default) or :immediately.
# action: :enable To create the monitoring config (default), or :disable to remove it.
# variables: Hash of instance variables to pass to the ERB template
# template_cookbook: the cookbook in which the configuration resides
# template_source: filename of the ERB configuration template, defaults to <LWRP Name>.conf.erb
define :monitrc, action: :enable, reload: :delayed, variables: {},
    template_cookbook: nil, template_source: nil do

  params[:template_source] ||= "etc/monit/#{params[:name]}.erb"
  template "/etc/monit/conf.d/#{params[:name]}.conf" do
    owner "root"
    group "root"
    mode 0644
    source params[:template_source] if params[:template_source]
    cookbook params[:template_cookbook]
    variables params[:variables]
    notifies :restart, resources(service: 'monit'), params[:reload]
    action(params[:action] == :enable ? :create : :delete)
  end

end