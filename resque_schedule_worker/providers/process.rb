action :create do
  service_dir = ::File.join(node[:rsw][:sv],new_resource.service_name)

  [node[:rsw][:sv], service_dir].each do |dir|
    directory dir do
      recursive true
      owner node[:rsw][:user]
      group node[:rsw][:user]
    end
  end

  daemontools_service new_resource.service_name do
    cookbook 'resque_schedule_worker'
    variables :service_directory => service_dir
    template "rsw"
    directory service_dir
    owner node[:rsw][:user]
    group node[:rsw][:user]
    env new_resource.env
    log true 
    supports :start => true,
      :stop    => true,
      :restart => true
    action [:enable, :start, :restart]
  end
end
