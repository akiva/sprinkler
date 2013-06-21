package :mysql, provides: :database do
  description 'MySQL database'
  apt %w(mysql-server mysql-client)
  requires :mysql_config
end

package :mysql_config do
  description 'MySQL configuration file'
  template = File.join(Dir.pwd, 'assets', 'my.conf')
  config_file = '/etc/mysql/my.conf'

  transfer template, config_file, render: true

  verify do
    has_file config_file
  end
end
