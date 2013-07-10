require_relative '../packages/debian/nginx'
require_relative '../packages/debian/openssl'
require_relative '../packages/debian/sphinx'
require_relative '../packages/debian/graphicsmagick'
require_relative '../packages/debian/logrotate'
require_relative '../packages/debian/memcached'
require_relative '../packages/generic/rbenv'

policy :http_server, roles: :app do
  requires :ruby_rbenv
  requires :http
  requires :openssl
  requires :logrotate
  requires :image_processing
  requires :memcached
end
