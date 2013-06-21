package :logrotate do
  description 'logrotate for automated log management'
  apt 'logrotate'
  requires :logrotate_logs

  verify do
    has_apt 'logrotate'
  end
end

package :logrotate_logs do
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

  push_text config_text, config_file do
    pre :install, "rm -f #{config_file} && touch #{config_file}"
    post :install, "chmod 0644 #{config_file}"
  end

  verify do
    has_file '/etc/logrotate.d/app'
  end
end
