package :new_relic, provides: :monitoring do
  description 'New Relic server monitoring'
  requires :new_relic_install
end

package :new_relic_repo do
  description 'Add official New Relic repositories for Ubuntu'
  repo_file = '/etc/apt/sources.list.d/newrelic.list'
  repo_url = 'http://download.newrelic.com/debian/newrelic.list'
  runner "sudo wget -O #{repo_file} #{repo_url}",
         'sudo apt-key adv --keyserver hkp://subkeys.pgp.net --recv-keys 548C16BF'

  verify do
    file_contains repo_file, 'newrelic'
  end
end

package :new_relic_install do
  description 'Install New Relic from the official resources'
  requires :new_relic_repo
  license_key = fetch(:new_relic_license_key)

  apt 'newrelic-sysmond', sudo: true do
    pre :install, 'sudo apt-get update'
    post :install, "sudo nrsysmond-config --set license_key=#{license_key}",
                   'sudo /etc/init.d/newrelic-sysmond start'
  end

  verify do
    has_process 'nrsysmond'
  end
end
