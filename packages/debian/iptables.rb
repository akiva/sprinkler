package :iptables, provides: :firewall do
  description 'IPtables firewall'

  apt 'iptables', sudo: true
  runner 'sudo /etc/network/if-pre-up.d/iptables'
  requires :iptables_rules, :iptables_ifconfig

  verify do
    has_apt 'iptables'
  end
end

package :iptables_rules do
  description 'IPtables firewall rules'
  config_file = '/etc/iptables.up.rules'
  config_template = File.join(Dir.pwd, 'assets', 'iptables')
  transfer config_template, config_file, sudo: true

  verify do
    has_file '/etc/iptables.up.rules'
    file_contains config_file, 'Sprinkle'
  end
end

package :iptables_ifconfig do
  description 'Setup IPtables firewall with network'
  config_file = '/etc/network/if-pre-up.d/iptables'
  config_template = File.join(Dir.pwd, 'assets', 'iptables_ifup')
  transfer config_template, config_file, sudo: true

  verify do
    has_file config_file
    file_contains config_file, 'Sprinkle'
  end
end
