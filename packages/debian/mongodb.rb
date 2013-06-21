package :mongodb, provides: :database do
  description 'MongoDB database server'
  requires :mongodb_10gen_repo, :mongodb_directory

  apt 'mongodb-10gen' do
    pre :install, 'aptitude update'
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

  runner 'apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10'
  runner "echo '#{repo}' | sudo tee #{repo_dir}/#{repo_file}"

  verify do
    file_contains "#{repo_dir}/#{repo_file}", repo
  end
end

package :mongodb_directory do
  runner 'mkdir /srv/mongodb'
  runner 'chown root /srv/mongodb'
  runner 'chgrp root /srv/mongodb'
  runner 'chmod 755 /srv/mongodb'

  verify do
    has_directory '/srv/mongodb'
  end
end
