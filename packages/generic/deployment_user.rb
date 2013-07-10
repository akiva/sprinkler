package :deployment_user do
  description 'Create a deployment user'
  requires :create_deployment_user,
           :deployment_user_permissions,
           :deployment_user_dotfiles,
           :deployment_user_ssh_key,
           :deployment_user_ssh_config
  requires :deployment_user_authorized_keys if fetch(:include_ssh_authorized_keys)
end

package :create_deployment_user do
  description 'Creates the deployment user'
  user = fetch(:deployment_user)
  user_password = fetch(:deployment_user_password)
  runner "useradd -m -s /bin/bash #{user}"
  runner "echo '#{user}:#{user_password}' | chpasswd"
  push_text "#{user} ALL=(ALL) NOPASSWD:ALL", '/etc/sudoers'

  verify do
    file_contains '/etc/passwd', "#{user}"
    file_contains '/etc/sudoers', "#{user}"
    has_directory "/home/#{user}"
  end
end

package :deployment_user_ssh_config do
  description 'Deployment user SSH config file'
  user = fetch(:deployment_user)
  template = `cat #{File.join(Dir.pwd, 'assets', 'user', 'ssh', 'config')}`
  config_file = "/home/#{user}/.ssh/config"
  push_text template, config_file do
    post :install, "chown #{user}:#{user} #{config_file}"
  end

  verify do
    has_file config_file
  end
end

package :deployment_user_ssh_key do
  description 'Generate deployment user SSH keys'
  user = fetch(:deployment_user)

  runner "ssh-keygen -b 4096 -t rsa -q -N '' -f /home/#{user}/.ssh/id_rsa"
  runner "chown -R #{user}:#{user} /home/#{user}/.ssh"
  runner "chmod 700 /home/#{user}/.ssh"
  runner "chmod 600 /home/#{user}/.ssh/authorized_keys"

  verify do
    has_file "/home/#{user}/.ssh/id_rsa"
    has_file "/home/#{user}/.ssh/id_rsa.pub"
  end
end

package :deployment_user_authorized_keys do
  description 'Add authorized keys from templates for deployment user'
  user = fetch(:deployment_user)
  keys_template = `cat #{File.join(Dir.pwd, 'assets', 'user', 'ssh', 'authorized_keys')}`
  keys_file = "/home/#{user}/.ssh/authorized_keys"

  push_text keys_template, keys_file

  verify do
    has_file keys_file
    file_contains keys_file, 'Sprinkle'
  end
end

package :deployment_user_permissions do
  description 'Set permissions and ownership for deployment user home directory'
  user = fetch(:deployment_user)
  home = "/home/#{user}"
  ssh_directory = "#{home}/.ssh"
  authorized_keys = "#{ssh_directory}/authorized_keys"
  runner "mkdir -p #{ssh_directory} && chmod 0700 #{ssh_directory}"
  runner "chown -R #{user}:#{user} #{ssh_directory}"
  runner "touch #{authorized_keys} && chmod 0700 #{authorized_keys}"
end

package :deployment_user_dotfiles do
  description 'Configure deployment user\'s home directory dot files'
  user = fetch(:deployment_user)
  home = "/home/#{user}"
  templates = %w( profile gemrc bashrc )

  templates.each do |template|
    transfer File.join(Dir.pwd, 'assets', 'user', template),
             "#{home}/.#{template}" do
      post :install, "chown -R #{user}:#{user} #{home}/.#{template}"
    end
  end

  verify do
    templates.each do |template|
      has_file "#{home}/.#{template}"
    end
  end
end
