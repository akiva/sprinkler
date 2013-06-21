package :ssh do
  description 'OpenSSH server with authorized_keys'
  apt 'openssh-server'
  # requires :ssh_keys, :ssh_config, :sshd_config, :ssh_restart

  verify do
    has_apt 'openssh-server'
  end
end

# package :ssh_keys do
#   description 'Generate default SSH key'
#
#   noop do
#     pre :install, %{ssh-keygen -t rsa -N '' -f /root/.ssh/id_rsa} # TODO: -C "#{deployer}@#{domain}"
#     post :install, '/etc/init.d/ssh reload'
#   end
#
#   verify do
#     has_file '/root/.ssh/id_rsa'
#     has_file '/root/.ssh/id_rsa.pub'
#   end
# end

# package :ssh_config do
#   description "Default SSH config"
#
#   config_file = '/etc/ssh/ssh_config'
#   config_template = File.join(File.dirname(__FILE__), '..', 'assets', 'ssh_config')
#
#   transfer config_template, config_file do
#     post :install, "/etc/init.d/ssh reload"
#   end
#
#   verify do
#     file_contains config_file, `head -n 1 #{config_template}`
#   end
# end
#
# package :sshd_config do
#   description "Default SSHD config"
#
#   config_file = '/etc/ssh/sshd_config'
#   config_template = File.join(File.dirname(__FILE__), '..', 'assets', 'sshd_config')
#
#   transfer config_template, config_file do
#     post :install, "/etc/init.d/ssh reload"
#   end
#
#   verify do
#     file_contains config_file, `head -n 1 #{config_template}`
#   end
# end
#
# %w[start stop restart reload].each do |command|
#   package :"ssh_#{command}" do
#     runner "/etc/init.d/ssh #{command}"
#   end
# end












# package :ssh_authorized_keys do
#   description 'Installs default OpenSSH authorized_keys for deployer_account (not for root)'
#   deployer_account = config(:OPENSSH_USER_ACCOUNT, required: true)
#   authorized_keys = "~#{deployer_account}/.ssh/authorized_keys"
#   authorized_keys_src = config(:OPENSSH_AUTHORIZED_KEYS)
#   template = File.join(Dir.pwd,
#                        'packages',
#                        'assets',
#                        'authorized_keys.txt.erb')
#   authorized_keys_content = File.read(File.expand_path(authorized_keys_src)).strip
#   timestamp = Time.now.strftime('%d %B %Y %H:%M')
#
#   transfer template,
#            '/tmp/authorized_keys',
#            sudo: true,
#            render: true,
#            locals: { timestamp: timestamp,
#                      authorized_keys: authorized_keys_content } do
#     # Created as root when Capistrano use_sudo is set
#     post :install, "mkdir -p #{File.dirname(authorized_keys)}"
#     post :install, "mv /tmp/authorized_keys #{authorized_keys}"
#     post :install, "chmod 644 #{authorized_keys}"
#     post :install, "chown -R #{deployer_account}: #{File.dirname(authorized_keys)}"
#   end
#
#   verify do
#     has_file authorized_keys
#     file_contains authorized_keys, "^# Begin Sprinkle block #{timestamp}$"
#     file_contains authorized_keys, "^# End Sprinkle block #{timestamp}$"
#   end
#
# end if config(:OPENSSH_AUTHORIZED_KEYS)

# package :ssh_disable_password_authentication do
#   description 'Disables SSH tunnelled cleartext passwords'
#   sshd_config = '/etc/ssh/sshd_config'
#   requires :openssh
#   requires :openssh_authorized_keys
#
#   runner "sed -E -i -e 's/^.*PasswordAuthentication (yes|no)/PasswordAuthentication no/g' #{sshd_config}" do
#     post :install, 'service ssh restart'
#   end
#
#   verify do
#     file_contains sshd_config, '^PasswordAuthentication no'
#   end
# end if config(:OPENSSH_AUTHORIZED_KEYS)
#
# package :ssh_disable_root_login do
#   description 'Disables root logins via SSH'
#   requires :openssh
#   sshd_config = '/etc/ssh/sshd_config'
#
#   noop do
#     post :install,
#          'sudo sed -i "s|^PermitRootLogin yes$|PermitRootLogin no|" /etc/ssh/sshd_config',
#          'sudo /etc/init.d/ssh restart'
#   end
#
#   verify do
#     file_contains '/etc/ssh/sshd_config', 'PermitRootLogin no'
#   end
# end
