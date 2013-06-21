require_relative '../packages/debian/ruby193'
require_relative '../packages/debian/nginx'
require_relative '../packages/debian/openssl'
require_relative '../packages/debian/mongodb'
require_relative '../packages/debian/redis'
require_relative '../packages/debian/sqlite'
require_relative '../packages/debian/sphinx'
require_relative '../packages/debian/graphicsmagick'
require_relative '../packages/debian/logrotate'
require_relative '../packages/debian/openssl'
require_relative '../packages/generic/deploy_user'
# require_relative '../packages/generic/http_directory'
require_relative '../packages/debian/memcached'
require_relative '../packages/generic/rbenv'

policy :http_server, roles: :app do
  requires :ruby193
  requires :deploy_user
  requires :rbenv
  requires :http
  # requires :http_directory
  requires :openssl
  requires :logrotate
  requires :image_processing
  requires :memcached
end
