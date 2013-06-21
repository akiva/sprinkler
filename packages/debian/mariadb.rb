package :mariadb, provides: :database do
  description 'MariaDB is a MySQL drop-in replacement with many improvements'
  requires :mariadb_repo, :mariadb_config
  apt 'mariadb-server'

  verify do
    has_apt 'mariadb-server'
    has_process 'mysqld'
  end
end

package :mariadb_repo do
  description 'Add official MariaDB Aptitude repositories for Ubuntu'
  requires :software_properties_common
  repo_dir = '/etc/apt/sources.list.d'
  repo_file = "#{repo_dir}/mariadb.list"
  repo_body = 'deb http://ftp.osuosl.org/pub/mariadb/repo/10.0/ubuntu quantal main'

  runner "rm -f #{repo_file} && echo '#{repo_body}' > #{repo_file}"
  runner 'apt-key adv --keyserver keyserver.ubuntu.com --recv 0xcbcb082a1bb943db'
  runner 'apt-get update'

  verify do
    file_contains repo_file, 'mariadb'
  end
end

package :software_properties_common do
  description 'software-properties-common package'
  apt 'software-properties-common'

  verify do
    has_apt 'software-properties-common'
  end
end

package :mariadb_config do
  description 'MariaDB configuration file'
  template = File.join(Dir.pwd, 'assets', 'my.conf')
  config_file = '/etc/mysql/my.conf'

  transfer template, config_file, render: true

  verify do
    has_file config_file
  end
end
