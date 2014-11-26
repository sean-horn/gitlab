name             'gitlab'
maintainer       'Stephen Lauck'
maintainer_email 'lauck@getchef.com'
license          'All rights reserved'
description      'Installs/Configures gitlab'
long_description 'Installs/Configures gitlab'
version          '0.1.2'

%w{ sshd postfix yum apt }.each do |cb|
  depends cb
end
