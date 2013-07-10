package :redis, provides: :database do
  description 'Redis database server'
  apt 'redis-server', sudo: true
  requires :redis_directory, :redis_conf

  verify do
    has_apt 'redis-server'
    has_process 'redis-server'
  end
end

package :redis_conf do
  description 'Configuration for Redis'
  template = File.join(Dir.pwd, 'assets', 'redis.conf')

  transfer template, '/tmp', sudo: true do
    pre :install, 'sudo mkdir -p /etc/redis'
    post :install, 'sudo mv /tmp/redis.conf /etc/redis/6379.conf',
                   'sudo service redis-server restart'
  end

  verify do
    has_file '/etc/redis/6379.conf'
    file_contains '/etc/redis/6379.conf', '/srv/mongodb'
  end
end

package :redis_directory do
  description 'Create redis /srv/ directory'
  runner 'sudo mkdir /srv/redis',
         'sudo chown -R redis:redis /srv/redis',
         'sudo chmod 755 /srv/redis'

  verify do
    has_directory '/srv/redis'
  end
end
