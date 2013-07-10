package :build_essentials do
  description 'Build tools'

  apt 'build-essential', sudo: true do
    pre :install, 'sudo aptitude update',
                  'sudo locale-gen en_GB.UTF-8',
                  'sudo /usr/sbin/update-locale LANG=en_GB.UTF-8',
                  'sudo aptitude safe-upgrade -y',
                  'sudo aptitude full-upgrade'
  end

  pkgs = %w[
    zlib1g-dev
    libssl-dev
    libreadline-dev
    libcurl4-openssl-dev
  ]

  apt pkgs, sudo: true

  verify do
    has_apt 'build-essential'
    has_executable 'gcc'
    pkgs.each do |pkg|
      has_apt pkg
    end
  end
end
