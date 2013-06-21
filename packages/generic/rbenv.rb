require_relative './deployment_user'

package :rbenv do
  description 'Ruby environment manager'
  requires :deployment_user
  user = fetch(:deployment_user)
  install_file = "/home/#{user}/install_rbenv"
  install_template = File.join(Dir.pwd, 'assets', 'install_rbenv')

  transfer install_template, install_file do
    post :install, "chmod +x #{install_file}",
                   "chown #{user}:#{user} #{install_file}",
                   "su #{user} -c '#{install_file}'",
                   "rm -rf #{install_file}"
  end

  verify do
    has_file "/home/#{user}/.rbenv/bin/ruby-local-exec"
  end
end
