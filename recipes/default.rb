#
# Cookbook Name:: gitlab
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'sshd'
include_recipe 'postfix'

download_url = "https://downloads-packages.s3.amazonaws.com/centos-7.0.1406/gitlab-7.4.3_omnibus.1-1.el7.x86_64.rpm"
filename = "centos-7.0.1406/gitlab-7.4.3_omnibus.1-1.el7.x86_64.rpm"

execute "gitlab-ctl reconfigure" do
  action :nothing
end

remote_file "#{Chef::Config['file_cache_path']}/#{filename}" do
  source download_url
  mode '0644'
  checksum node['chef_server']['checksum']
end

package "gitlab" do
  source "#{Chef::Config['file_cache_path']}/#{filename}"
  action :install
  notifies :run, "execute[gitlab-ctl reconfigure]", :immediately
end
