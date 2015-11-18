#
# Cookbook Name:: testweb
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt::default'

package 'nginx' do
  action :install
end

package 'php5-fpm' do
  action :install
end

package 'zend-framework' do
  action :install
end

service 'nginx' do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end

cookbook_file '/usr/share/nginx/html/index.php' do
  source 'info.php'
  owner 'www-data'
  group 'www-data'
  mode '0644'
  notifies :restart, 'service[nginx]'
end

cookbook_file '/etc/nginx/sites-available/default' do
  source 'default_nginx.conf'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[nginx]'
end

file '/usr/share/nginx/html/index.html' do
  action :delete
  notifies :restart, 'service[nginx]'
end

ruby_block "update php path" do
	block do
		rc = Chef::Util::FileEdit.new("/etc/php5/fpm/php.ini")
		rc.insert_line_if_no_match(
			/^include_path/,
			'include_path = ".:/usr/share/php:/usr/share/php/libzend-framework-php"'
		)
		rc.write_file
	end
end

cookbook_file '/etc/start_nginx.bash' do
  source 'start_nginx.bash'
  owner 'root'
  group 'root'
  mode '0755'
end


