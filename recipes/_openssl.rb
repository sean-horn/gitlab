#
# Cookbook Name:: gitlab
# Recipe:: _openssl
#
# Copyright (C) 2014, Chef Software, Inc <legal@getchef.com>
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'openssl'

directory '/etc/gitlab'

directory '/etc/gitlab/ssl' do
  mode '0700'
end

ssl_name = URI(node['gitlab']['external_url']).host

openssl_x509 "/etc/gitlab/ssl/#{ssl_name}.crt" do
  common_name ssl_name
  org node['gitlab']['ssl']['organization']
  org_unit node['gitlab']['ssl']['organizational_unit']
  country node['gitlab']['ssl']['country']
end
