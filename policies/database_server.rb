require_relative '../packages/debian/mysql'
require_relative '../packages/debian/mariadb'
require_relative '../packages/debian/mongodb'
require_relative '../packages/debian/redis'
require_relative '../packages/debian/sqlite'
# require_relative '../packages/debian/sphinx'

policy :database_server, roles: :db do
  requires :database
  # requires :sphinx
end
