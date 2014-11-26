case node['platform_family']
when 'debian'
  default['gitlab']['omnibus']['url'] = "https://downloads-packages.s3.amazonaws.com/ubuntu-14.04/gitlab_7.4.3-omnibus.1-1_amd64.deb"
  default['gitlab']['omnibus']['checksum'] = "e33a540089f9489b8af69c6e55f3e656"
when 'rhel'
  default['gitlab']['omnibus']['url'] = {'centos-7' => 'https://downloads-packages.s3.amazonaws.com/centos-7.0.1406/gitlab-7.4.3_omnibus.1-1.el7.x86_64.rpm', 'centos-6' => 'https://downloads-packages.s3.amazonaws.com/centos-6.6/gitlab-7.5.1_omnibus.5.2.0.ci-1.el6.x86_64.rpm'}
  default['gitlab']['omnibus']['checksum'] = {'centos-7' => 'e33a540089f9489b8af69c6e55f3e656', 'centos-6' => 'bbf7761126d59861b3983b6820550690'}
end

default['gitlab']['external_url'] = "https://gitlab.mycompany.com"
default['gitlab']['omnibus']['in_repo'] = false
