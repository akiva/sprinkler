require_relative '../packages/debian/apt_update_index'
require_relative '../packages/debian/apt_upgrade'
require_relative '../packages/debian/build_essentials'
require_relative '../packages/debian/hostname'
require_relative '../packages/debian/ntp'

policy :base, roles: :app do
  requires :apt_update_index
  requires :apt_upgrade
  requires :build_essentials
  requires :ntp
  requires :hostname
end
