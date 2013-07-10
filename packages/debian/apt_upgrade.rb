package :apt_upgrade do
  description 'Runs apt-get upgrade'
  runner 'sudo apt-get upgrade -y'
end
