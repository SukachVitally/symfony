home_dir = node[:home_dir]
dev_owner = node[:dev_owner]
venv_dir = node[:venv_dir]

directory "#{home_dir}" do
    owner dev_owner
    mode '0777'
    action :create
end

execute 'venv init' do
  user dev_owner
  command "virtualenv #{venv_dir}"
  action :run
end
Chef::Log.warn("Virtualenv directory created")

template "/home/vagrant/start.sh" do
    source 'start.sh.erb'
    mode '0755'
    owner dev_owner
    variables(
        :venv_dir => venv_dir
    )
end

template "/etc/nginx/nginx.conf" do
    source 'nginx.conf.erb'
    mode '0644'
end

service "nginx" do
  action :start
end
