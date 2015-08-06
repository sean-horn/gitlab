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
include_recipe 'gitlab::_openssl'\
if URI(node['gitlab']['external_url']).scheme == 'https'

execute 'gitlab-ctl reconfigure' do
  action :nothing
end

unless node['gitlab']['omnibus']['in_repo']
  download_url = node['gitlab']['omnibus']['url']['distro']
  filename = File.basename(node['gitlab']['omnibus']['url']['distro'])
  chksm = node['gitlab']['omnibus']['checksum']['distro']
  
  remote_file "#{Chef::Config['file_cache_path']}/#{filename}" do
    source download_url
    mode '0644'
    checksum chksm
  end
end
