package :apt_upgrade do
  description 'Runs apt-get upgrade'
  runner 'apt-get upgrade -y'
end
