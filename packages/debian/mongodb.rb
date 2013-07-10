package :mongodb, provides: :database do
  description 'MongoDB database server'
  requires :mongodb_10gen_repo, :mongodb_install, :mongodb_config
end

package :mongodb_install do
  description 'Install MongoDB from 10gen repo'

  apt 'mongodb-10gen', sudo: true do
    pre :install, 'sudo aptitude update'
  end

  verify do
    has_apt 'mongodb-10gen'
  end
end

package :mongodb_10gen_repo do
  description 'Add 10gen Aptitude repositories for MongoDB'
  repo_dir = '/etc/apt/sources.list.d'
  repo_file = '10gen.list'
  repo = 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen'

  runner 'sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10',
         "sudo echo '#{repo}' | sudo tee #{repo_dir}/#{repo_file}"

  verify do
    file_contains "#{repo_dir}/#{repo_file}", repo
  end
end

package :mongodb_config do
  description 'Config file for MongoDB'
  requires :mongodb_directory
  template = File.join(Dir.pwd, 'assets', 'mongodb.conf')
  config_file = '/etc/mongodb.conf'

  file config_file, content: File.read(template), sudo: true do
    post :install, "sudo chown root:root #{config_file}"
    post :install, 'sudo service mongodb restart'
  end

  verify do
    has_file config_file
    file_contains config_file, '/srv/mongodb'
  end
end

package :mongodb_directory do
  runner 'sudo mkdir /srv/mongodb',
         'sudo chown -R mongodb:mongodb /srv/mongodb',
         'sudo chmod 755 /srv/mongodb'

  verify do
    has_directory '/srv/mongodb'
  end
end
