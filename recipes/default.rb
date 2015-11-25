#
# Cookbook Name:: testweb
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'httpd' do
  action :install
end

service 'httpd' do
  supports :status => true, :restart => true, :reload => true
  action [ :start, :enable ]
end

%w[ /var/www /var/www/html ].each do |path|
  directory path do
    owner 'apache'
    group 'apache'
    mode '0755'
  end
end

cookbook_file '/var/www/html/index.html' do
  source 'index.html'
  owner 'apache'
  group 'apache'
  mode '0644'
end

