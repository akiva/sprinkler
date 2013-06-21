require_relative '../generic/http_directory'

package :nginx, provides: :http do
  description 'nginx HTTP and proxy server'
  apt 'nginx-full'
  requires :nginx_conf

  verify do
    has_apt 'nginx-full'
    has_process 'nginx'
  end
end

package :nginx_conf do
  description 'nginx configuration files'
  requires :http_directory
  config_file = '/etc/nginx/nginx.conf'
  template = File.join(Dir.pwd, 'assets', 'nginx.conf.erb')

  transfer template, config_file, render: true do
    pre :install, "rm -f #{config_file}"
    post :install, 'sudo service nginx restart'
  end

  verify do
    file_contains config_file, 'Created by Sprinkle'
    has_process 'nginx'
  end
end
