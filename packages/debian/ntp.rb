package :ntp do
  description 'NTP'

  apt 'ntp', sudo: true do
    post :install, 'sudo ntpdate -u ntp.ubuntu.com'
  end

  verify do
    has_apt 'ntp'
  end
end
