package :deployment_user do
  description 'Create the deployment user'
  requires :create_deployment_user,
           :deployment_user_permissions,
           :deployment_user_dotfiles
  requires :deployment_user_ssh if fetch(:include_ssh_authorized_keys)
end

package :create_deployment_user do
  description 'Creates the deployer user'
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

package :deployment_user_ssh do
  description 'Add deployment user authorized keys'
  user = fetch(:deployment_user)
  authorized_keys_template = `cat #{File.join(Dir.pwd, 'assets', 'user', 'ssh', 'authorized_keys')}`
  authorized_keys_file = "/home/#{user}/.ssh/authorized_keys"
  config_template = `cat #{File.join(Dir.pwd, 'assets', 'user', 'ssh', 'config')}`
  config_file = "/home/#{user}/.ssh/config"

  push_text authorized_keys_template, authorized_keys_file
  push_text config_template, config_file

  verify do
    has_file authorized_keys_file
    has_file config_file
  end
end

package :deployment_user_permissions do
  description 'Set permissions and ownership for deployment user home directory'
  user = fetch(:deployment_user)
  runner "chmod 0700 /home/#{user}/.ssh"
  runner "chown -R #{user}:#{user} /home/#{user}/.ssh"
  runner "chmod 0700 /home/#{user}/.ssh/authorized_keys"
end

package :deployment_user_dotfiles do
  description 'Configure deployment user\'s home directory dot files'
  user = fetch(:deployment_user)
  templates = %w( profile gemrc bashrc )

  templates.each do |template|
    transfer File.join(Dir.pwd, 'assets', 'user', template),
             "/home/#{user}/.#{template}",
             render: true do
      post :install, "chown -R #{user}:#{user} /home/#{user}/.#{template}"
    end
  end

  verify do
    templates.each do |template|
      has_file "/home/#{user}/.#{template}"
    end
  end
end
