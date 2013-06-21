package :build_essentials do
  description 'Build tools'

  apt 'build-essential' do
    pre :install, 'aptitude update'
    pre :install, 'locale-gen en_GB.UTF-8'
    pre :install, '/usr/sbin/update-locale LANG=en_GB.UTF-8'
    pre :install, 'aptitude safe-upgrade -y'
    pre :install, 'aptitude full-upgrade'
  end

  pkgs = %w(
    zlib1g-dev
    libssl-dev
    libreadline-dev
    libcurl4-openssl-dev
  )

  apt pkgs

  verify do
    has_apt 'build-essential'
    has_executable 'gcc'
    pkgs.each do |pkg|
      has_apt pkg
    end
  end
end
