package :mariadb, provides: :database do
  description 'MariaDB is a MySQL drop-in replacement with many improvements'
  requires :mariadb_install, :mariadb_directory, :mariadb_config
end

package :mariadb_repo do
  description 'Add official MariaDB Aptitude repositories for Ubuntu'
  requires :software_properties_common
  repo_dir = '/etc/apt/sources.list.d'
  repo_file = "#{repo_dir}/mariadb.list"
  repo_body = 'deb http://ftp.osuosl.org/pub/mariadb/repo/10.0/ubuntu quantal main'

  runner "sudo rm -f #{repo_file} && echo '#{repo_body}' | sudo tee #{repo_file}",
         'sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 0xcbcb082a1bb943db',
         'sudo apt-get update'

  verify do
    file_contains repo_file, 'mariadb'
  end
end

package :software_properties_common do
  description 'software-properties-common package'
  apt 'software-properties-common', sudo: true

  verify do
    has_apt 'software-properties-common'
  end
end

package :mariadb_install do
  description 'MariaDB server installation'
  requires :mariadb_repo
  apt 'mariadb-server mariadb-client libmariadbclient-dev', sudo: true

  verify do
    has_apt 'mariadb-server'
    has_apt 'mariadb-client'
    has_apt 'libmariadbclient-dev'
    has_process 'mysqld'
  end
end

package :mariadb_config do
  description 'MariaDB configuration file'
  template = File.join(Dir.pwd, 'assets', 'my.conf')
  config_file = '/etc/mysql/my.conf'

  file config_file, content: File.read(template), sudo: true do
    post :install, 'sudo service mysql restart'
  end

  verify do
    has_file config_file
  end
end

package :mariadb_directory do
  description 'Create MariaDB /srv/ directory'
  runner 'sudo mkdir /srv/mysql',
         'sudo chown -R mysql:mysql /srv/mysql',
         'sudo chmod 755 /srv/mysql'

  verify do
    has_directory '/srv/mysql'
  end
end
