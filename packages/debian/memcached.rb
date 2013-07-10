package :memcached do
  description 'Memcached, a distributed memory object store'
  requires :memcached_apt, :memcached_conf
end

package :memcached_apt do
  user = fetch(:user)
  apt 'memcached', sudo: true do
    pre :install, 'sudo mkdir -p /var/log/memcached',
                  "sudo chown #{user}:#{user} -R /var/log/memcached"
  end

  verify do
    has_executable 'memcached'
  end
end

package :memcached_conf do
  user = fetch(:user)
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

  push_text config_text, config_file, sudo: true do
    pre :install, "sudo rm -f #{config_file} && sudo touch #{config_file}"
  end

  verify do
    file_contains config_file, 'Sprinkle'
  end
end
