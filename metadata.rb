name             'gitlab'
maintainer       'YOUR_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures gitlab'
long_description 'Installs/Configures gitlab'
version          '0.1.0'

%w{ sshd postfix yum apt }.each do |cb|
  depends cb
end