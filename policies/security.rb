require_relative '../packages/debian/iptables'
require_relative '../packages/debian/ufw'
require_relative '../packages/debian/monit'

# TODO implement further security features, such as:
#   - hardening OpenSSH,
#   - regular backups of files, projects, and databases
#   - system monitoring
#   - notifications
#
#   Monit monitoring
#   - https://github.com/dkeskar/sliceconf/blob/master/packages/database.rb
#   - https://github.com/dkeskar/sliceconf/blob/master/packages/monit.rb
#   - https://github.com/dkeskar/sliceconf/blob/master/packages/webserver.rb
#   - https://github.com/dkeskar/sliceconf/tree/master/monitoring
#   - https://github.com/dkeskar/sliceconf/blob/master/lib/fixups
#   - https://github.com/grimen/sprinkle-stack/tree/master/packages/process_monitoring
#
#   Fail2ban
#   - https://github.com/grimen/sprinkle-stack/tree/master/packages/security

policy :security, roles: :app do
  requires :firewall
  requires :monitoring
end
