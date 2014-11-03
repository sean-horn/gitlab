case node['platform_family']
when 'debian'
  default['gitlab']['omnibus']['url'] = "https://downloads-packages.s3.amazonaws.com/ubuntu-14.04/gitlab_7.4.3-omnibus.1-1_amd64.deb"
  default['gitlab']['omnibus']['checksum'] = "e33a540089f9489b8af69c6e55f3e656"
when 'rhel'
  default['gitlab']['omnibus']['url'] = "https://downloads-packages.s3.amazonaws.com/centos-7.0.1406/gitlab-7.4.3_omnibus.1-1.el7.x86_64.rpm"
  default['gitlab']['omnibus']['checksum'] = "e33a540089f9489b8af69c6e55f3e656"
end


default['gitlab']['external_url'] = "http://gitlab.mycompany.com"
