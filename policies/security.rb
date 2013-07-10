require_relative '../packages/debian/iptables'
require_relative '../packages/debian/ufw'
require_relative '../packages/debian/monit'
require_relative '../packages/debian/new_relic'

policy :security, roles: :app do
  requires :firewall
  requires :monitoring
end
