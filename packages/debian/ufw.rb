package :ufw, provides: :firewall do
  description 'UFW Firewall'

  apt 'ufw' do
    post :install,
         'sudo ufw default deny',
         'sudo ufw allow 80',
         'sudo ufw allow 443',
         'sudo ufw allow 22',
         'echo -en "y\n" | sudo ufw enable'
  end

  verify do
    has_apt 'ufw'
  end
end
