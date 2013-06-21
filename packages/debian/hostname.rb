package :hostname do
  description 'Set hostname for host server'
  requires :hostname_in_etc_hosts
  hostnamerc = '/etc/hostname'
  hostname = fetch(:hostname)

  runner "echo '#{hostname}' > /etc/hostname"
  runner "hostname -F /etc/hostname"

  verify do
    file_contains hostnamerc, "^#{hostname}$"
  end
end

package :hostname_in_etc_hosts do
  description 'Adds entry in /etc/hosts for system hostname'
  hostsrc = '/etc/hosts'
  hostname = fetch(:hostname)
  fqdn = fetch(:fqdn)
  push_text "127.0.1.1 #{fqdn} #{hostname}", hostsrc

  verify do
    file_contains hostsrc, "^127.0.1.1 #{fqdn} #{hostname}$"
  end
end
