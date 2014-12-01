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

external_url = "http://#{node['fqdn']}"

execute "gitlab-ctl reconfigure" do
  action :nothing
end

unless node['gitlab']['omnibus']['in_repo']
  download_url = "https://downloads-packages.s3.amazonaws.com/centos-7.0.1406/gitlab-7.4.3_omnibus.1-1.el7.x86_64.rpm"
  filename = File.basename(node['gitlab']['omnibus']['url'])
  chksm = 'e33a540089f9489b8af69c6e55f3e656'
  
  remote_file "#{Chef::Config['file_cache_path']}/#{filename}" do
    source node['gitlab']['omnibus']['url']
    mode '0644'
    checksum chksm
  end
end

package "gitlab" do
  source "#{Chef::Config['file_cache_path']}/#{filename}" unless node['gitlab']['omnibus']['in_repo']
  action :install
end

template "/etc/gitlab/gitlab.rb" do
  source "gitlab.rb.erb"
  owner 'root'
  group 'root'
  mode '0600'
  variables(
    :external_url => node['gitlab']['external_url']
  )
  notifies :run, "execute[gitlab-ctl reconfigure]"
end
