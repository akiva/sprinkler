package :redis, provides: :database do
  description 'Redis database server'
  requires :redis_conf, :redis_directory
  apt 'redis-server'

  verify do
    has_apt 'redis-server'
    has_process 'redis-server'
  end
end

package :redis_conf do
  description 'Configuration for Redis'
  template = File.join(Dir.pwd, 'assets', 'redis.conf')

  transfer template, '/tmp' do
    pre :install, 'mkdir -p /etc/redis'
    post :install, 'mv /tmp/redis.conf /etc/redis/6379.conf'
  end

  verify do
    has_file '/etc/redis/6379.conf'
  end
end

package :redis_directory do
  runner 'mkdir /srv/redis'
  runner 'chown root /srv/redis'
  runner 'chgrp root /srv/redis'
  runner 'chmod 755 /srv/redis'

  verify do
    has_directory '/srv/redis'
  end
end
