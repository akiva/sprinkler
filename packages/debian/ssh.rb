package :ssh do
  description 'OpenSSH server with authorized_keys'
  apt 'openssh-server', sudo: true

  verify do
    has_apt 'openssh-server'
  end
  optional :ssh_disable_password_authentication,
           :ssh_disable_root_login
end

package :ssh_disable_password_authentication do
  description 'Disables SSH tunnelled cleartext passwords'
  sshd_config = '/etc/ssh/sshd_config'

  runner "sudo sed -E -i -e 's/^.*PasswordAuthentication (yes|no)/PasswordAuthentication no/g' #{sshd_config}" do
    post :install, 'sudo service ssh restart'
  end

  verify do
    file_contains sshd_config, '^PasswordAuthentication no'
  end
end

package :ssh_disable_root_login do
  description 'Disables root logins via SSH'
  sshd_config = '/etc/ssh/sshd_config'

  runner 'sudo sed -i "s|^PermitRootLogin yes$|PermitRootLogin no|" /etc/ssh/sshd_config',
         'sudo service ssh restart'

  verify do
    file_contains '/etc/ssh/sshd_config', 'PermitRootLogin no'
  end
end
