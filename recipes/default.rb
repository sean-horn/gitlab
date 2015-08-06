#
# Cookbook Name:: gitlab
# Recipe:: default
#
# Copyright (C) 2014, Chef Software, Inc <legal@getchef.com>
#
# All rights reserved - Do Not Redistribute
#

require 'uri'

include_recipe 'sshd'
include_recipe 'postfix'
if URI(node['gitlab']['external_url']).scheme == 'https'
  include_recipe 'gitlab::_openssl'
end

execute 'gitlab-ctl reconfigure' do
  action :nothing
end

unless node['gitlab']['omnibus']['in_repo']
  distro = '#{node['platform']}-#{node['platform_version'].split('.').first}'
  download_url = node['gitlab']['omnibus']['url']['distro']
  filename = File.basename(node['gitlab']['omnibus']['url']['distro'])
  chksm = node['gitlab']['omnibus']['checksum']['distro']
  
  remote_file '#{Chef::Config['file_cache_path']}/#{filename}' do
    source download_url
    mode '0644'
    checksum chksm
  end
end

package 'gitlab' do
  source '#{Chef::Config['file_cache_path']}/#{filename}' unless node['gitlab']['omnibus']['in_repo']
  action :install
end

template '/etc/gitlab/gitlab.rb' do
  source 'gitlab.rb.erb'
  owner 'root'
  group 'root'
  mode '0600'
  variables(
    :external_url => node['gitlab']['external_url']
  )
  notifies :run, 'execute[gitlab-ctl reconfigure]'
end
