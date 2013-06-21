require_relative '../generic/deployment_user'

package :memcached do
  description 'memcached package'
  requires :deployment_user, :memcached_apt, :memcached_conf
end

package :memcached_apt do
  user = fetch(:deployment_user)
  apt 'memcached' do
    pre :install, 'mkdir -p /var/log/memcached',
                  "chown #{user}:#{user} -R /var/log/memcached"
  end

  verify do
    has_executable 'memcached'
  end
end

package :memcached_conf do
  user = fetch(:deployment_user)
  config_file = '/etc/memcached.conf'
  config_text = %q[
# memcached_conf via Sprinkle
logfile /var/log/memcached/memcached.log
-d
-v
-m 64
-p 11211
-u #{user}
-l 127.0.0.1
].lstrip

  push_text config_text, config_file do
    pre :install, "rm -f #{config_file} && touch #{config_file}"
  end

  verify do
    file_contains config_file, 'Sprinkle'
  end
end
