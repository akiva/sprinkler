package :logrotate do
  description 'Logrotate for automated log management'
  apt 'logrotate', sudo: true
  requires :logrotate_logs

  verify do
    has_apt 'logrotate'
  end
end

package :logrotate_logs do
  description 'Logrotate configuration for hosted apps'
  config_file = '/etc/logrotate.d/app'
  config_text = %q[
/srv/http/*/shared/log/*.log {
  rotate 30
  daily
  missingok
  notifempty
  compress
  delaycompress
  copytruncate
}
].lstrip

  push_text config_text, config_file, sudo: true do
    pre :install, "sudo rm -f #{config_file} && sudo touch #{config_file}"
    post :install, "sudo chmod 0644 #{config_file}"
  end

  verify do
    has_file '/etc/logrotate.d/app'
  end
end
