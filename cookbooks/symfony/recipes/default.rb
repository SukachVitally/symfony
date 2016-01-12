include_recipe 'build-essential::default'

package 'php'
package 'epel-release'
package 'nginx'
package 'php-fpm'
package 'php-common'
package 'vim'
package 'git'

execute 'autostart nginx' do
  command "chkconfig nginx on"
end

execute 'autostart php-fpm' do
  command "chkconfig php-fpm on"
end

##########################################
project_dir = node[:project_dir]
logs_dir = node[:logs_dir]
dev_owner = node[:dev_owner]

directory "#{logs_dir}" do
    owner dev_owner
    mode '0777'
    action :create
end

template "/etc/nginx/conf.d/project.conf" do
    source 'project.conf.erb'
    mode '0755'
    variables(
        :project_dir => project_dir,
        :logs_dir => logs_dir
    )
end


##########################################
########### Symfony install ##############
##########################################

execute 'Download symfony library' do
  command "curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony"
end

execute 'Set symfony lib as executed' do
  command "chmod a+x /usr/local/bin/symfony"
end
