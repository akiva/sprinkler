package :mysql, provides: :database do
  description 'MySQL database'
  apt %w(mysql-server mysql-client libmysqlclient-dev), sudo: true
  requires :mysql_directory, :mysql_config
end

package :mysql_config do
  description 'MySQL configuration file'
  template = File.join(Dir.pwd, 'assets', 'my.conf')
  config_file = '/etc/mysql/my.conf'

  file config_file, content: File.read(template), sudo: true do
    post :install, 'sudo service mysql restart'
  end

  verify do
    has_file config_file
  end
end

package :mysql_directory do
  description 'Create MySQL /srv/ directory'
  runner 'sudo mkdir /srv/mysql',
         'sudo chown -R mysql:mysql /srv/mysql',
         'sudo chmod 755 /srv/mysql'

  verify do
    has_directory '/srv/mysql'
  end
end
