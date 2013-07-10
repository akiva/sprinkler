require_relative '../generic/http_directory'

package :nginx, provides: :http do
  description 'nginx HTTP and proxy server'
  requires :nginx_full, :nginx_conf, :nginx_conf_d, :nginx_default_site
  verify do
    has_apt 'nginx-full'
    has_process 'nginx'
  end
end

package :nginx_full do
  description 'nginx full package'
  apt 'nginx-full', sudo: true
end

package :nginx_conf do
  description 'nginx configuration files'
  requires :http_directory
  config_file = '/etc/nginx/nginx.conf'
  template = File.join(Dir.pwd, 'assets', 'nginx', 'nginx.conf.erb')

  file config_file, content: File.read(template), sudo: true do
    pre :install, "sudo rm -f #{config_file}"
    post :install, 'sudo service nginx restart'
  end

  verify do
    file_contains config_file, 'Created by Sprinkle'
    has_process 'nginx'
  end
end

package :nginx_conf_d do
  description 'nginx configuration files for conf.d/ directory'
  config_dir = '/etc/nginx/conf.d/'
  template_dir = File.join(Dir.pwd, 'assets', 'nginx', 'conf.d')

  transfer template_dir, config_dir, sudo: true, recursive: true do
    post :install, 'sudo service nginx restart'
  end

  verify do
    has_directory config_dir
  end
end

package :nginx_default_site do
  description 'nginx default reverse proxy site configuration'
  default_file = '/etc/nginx/sites-available/default'
  template = File.join(Dir.pwd, 'assets', 'nginx', 'sites-available', 'default')

  transfer template, default_file, sudo: true do
    post :install, 'sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default'
    post :install, 'sudo service nginx restart'
  end

  verify do
    has_file default_file
  end
end
