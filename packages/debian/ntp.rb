package :ntp do
  description 'NTP'

  apt 'ntp' do
    post :install, 'ntpdate -u ntp.ubuntu.com'
  end

  verify do
    has_apt 'ntp'
  end
end
